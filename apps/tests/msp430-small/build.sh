#!/bin/bash

# Root directoruy of all targets.
ROOT_TARGETS=${TINYOS_ROOT_DIR_ADDITIONAL}/support/make/targets
# Root directory of all projects.
ROOT_APPS=${TINYOS_ROOT_DIR_ADDITIONAL}/apps/tests/msp430-small

# Large projects for small MCUs are expected to fail.
SMALL_MCUS=(msp430f2012 msp430f2013 msp430g2211 msp430g2231)
LARGE_PROJECTS=(ds1624/Temperature uart/Localtime)
# Known combination of fails.
FAIL_KNOWNS=(
    max549/Clock:ez430f2012,ez430f2013
    max7219/Clock:ez430f2012,ez430f2013
    uart/LocalTime:msp430f1121,msp430f1132
    uart/LocalTime:msp430f2012,msp430f2013,msp430f2131
    uart/LocalTime:msp430g2211,msp430g2231,msp430g2402,msp430g2452
)

if [[ -t 1 ]]; then
    COLOR_RED=$(tput setaf 1)
    COLOR_GREEN=$(tput setaf 2)
    COLOR_YELLOW=$(tput setaf 3)
    COLOR_BLUE=$(tput setaf 4)
    COLOR_OFF=$(tput sgr0)
else
    COLOR_RED=
    COLOR_GREEN=
    COLOR_BLUE=
    COLOR_YELLOW=
    COLOR_OFF=
fi

function in_array {
    local needle=$1; shift
    local item
    for item in "$@"; do
	[[ ${item} == ${needle} ]] && return 0
    done
    return 1
}

function get_mcu_of {
    local target="$1"
    local target_mcu
    for target_mcu in "${TARGET_MCUS[@]}"; do
	[[ ${target_mcu} =~ ^${target}: ]] \
	    && { echo "${target_mcu#${target}:}"; return 0; }
    done
    return 1
}

function get_targets_of {
    local mcu="$1"
    local target_mcu
    local -a targets
    for target_mcu in "${TARGET_MCUS[@]}"; do
	[[ ${target_mcu} =~ :${mcu}$ ]] && targets+=("${target_mcu%:${mcu}}")
    done
    echo "${targets[@]}"
}

function is_small_target {
    local target="$1"
    local mcu=$(get_mcu_of "${target}")
    in_array "${mcu}" "${SMALL_MCUS[@]}"
}

function is_large_project {
    local project="$1"
    in_array "${project}" "${LARGE_PROJECTS[@]}"
}

function insertion_sort {
    local -a list=("$@")
    local p i
    for ((p = 1; p < ${#list[@]}; p++)); do
	# search the insertion point of list[p].
	for ((i = p; i > 0; i--)); do
	    [[ "${list[i-1]}" < "${list[p]}" ]] && break
	done
	((i == p)) && continue
	# move list[p] before list[i]
	list=("${list[@]:0:i}" "${list[p]}" "${list[i]}" "${list[@]:i+1:p-(i+1)}" "${list[@]:p+1}")
    done
    echo "${list[@]}"
}

function setup_targets {
    TARGETS=()
    TARGET_MCUS=()
    MCUS=()

    local root="$1"
    local p target mcu
    for p in $(find "${root}" -name '*.target' | sort); do
	target=$(basename "${p}" .target)
	mcu=$(grep -w MSP_MCU "${p}" | sed -E 's/MSP_MCU *[?:]?= *(.*)$/\1/')
	TARGET_MCUS+=("${target}:${mcu}")
	in_array "${mcu}" "${MCUS[@]}" || MCUS+=("${mcu}")
    done
    for mcu in $(insertion_sort "${MCUS[@]}"); do
	TARGETS+=($(get_targets_of "${mcu}"))
    done
}

function setup_projects {
    PROJECTS=()

    local root="$1"
    local makefile
    for makefile in $(find "${root}" -name Makefile | sort); do
	PROJECTS+=($(dirname "${makefile#${root}/}"))
    done
}

function setup_expects {
    FAIL_EXPECTS=()
    PASS_EXPECTS=()

    local project_targets project targets mcu target
    for project_targets in "${FAIL_KNOWNS[@]}"; do
	project="${project_targets%:*}"
	targets="${project_targets#${project}:}"
	targets=(${targets//,/ })
	for target in "${targets[@]}"; do
	    if in_array "${target}" "${MCUS[@]}"; then
		mcu="${target}"
		for target in $(get_targets_of "${mcu}"); do
		    FAIL_EXPECTS+=("${project}:${target}")
		done
	    else
		FAIL_EXPECTS+=("${project}:${target}")
	    fi
	done
    done

    local project_target
    for target in "${TARGETS[@]}"; do
	for project in "${PROJECTS[@]}"; do
	    project_target="${project}:${target}"
	    if is_small_target "${target}" && is_large_project "${project}"; then
		in_array "${project_target}" "${FAIL_EXPECTS[@]}" \
		    || FAIL_EXPECTS+=("${project_target}")
	    fi
	    in_array "${project_target}" "${FAIL_EXPECTS[@]}" \
		|| PASS_EXPECTS+=("${project_target}")
	done
    done
}

function build_project {
    local taregt="$1" project="$2"
    local project_target="${project}:${target}"
    if make -C "${ROOT_APPS}/${project}" "${target}" >/dev/null 2>&1; then
	status="${COLOR_BLUE}PASS"
	in_array "${project_target}" "${PASS_EXPECTS[@]}" \
	    || status="${COLOR_GREEN}PASS!"
	[[ ${target} == clean ]] && status="DONE"
    else
	status="${COLOR_RED}FAIL!"
	in_array "${project_target}" "${FAIL_EXPECTS[@]}" \
	    && status="${COLOR_YELLOW}FAIL"
    fi
    echo "${status}: ${target} ${project}${COLOR_OFF}"
}

setup_targets "${ROOT_TARGETS}"
setup_projects "${ROOT_APPS}"
setup_expects

projects=()
targets=()
errors=()
if [[ -f Makefile ]]; then
    project="${PWD#${ROOT_APPS}/}"
    in_array "${project}" "${PROJECTS[@]}" \
	&& projects+=("${project}")
fi
for arg in "$@"; do
    if in_array "${arg%/}" "${PROJECTS[@]}"; then
	project="${arg%/}"
	projects+=("${project}")
    elif in_array "${arg}" "${TARGETS[@]}"; then
	target="${arg}"
	targets+=("${target}")
    elif in_array "${arg}" "${MCUS[@]}"; then
	mcu="${arg}"
	targets+=($(get_targets_of "${mcu}"))
    elif [[ $arg == clean ]]; then
	targets+=(clean)
    else
	errors+=("${arg}")
	echo "${COLOR_RED}@@@@@ Skip unknown argument: ${arg}${COLOR_OFF}" 1>&2
    fi
done
[[ ${#errors[@]} -gt 0 ]] && exit 0
[[ ${#projects[@]} -eq 0 ]] && projects=("${PROJECTS[@]}")
[[ ${#targets[@]} -eq 0 ]] && targets=("${TARGETS[@]}")
for target in "${targets[@]}"; do
    for project in "${projects[@]}"; do
	build_project "${target}" "${project}"
    done
done
