//$Id: VirtualizeTimerC.nc,v 1.13 2010-06-29 22:07:50 scipio Exp $

/* Copyright (c) 2000-2003 The Regents of the University of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holder nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * VirtualizeTimer16C uses a single Timer16 to create up to 255 virtual timers.
 *
 * <p>See TEP102 for more details.
 *
 * @param precision_tag A type indicating the precision of the Timer being 
 *   virtualized.
 * @param max_timers Number of virtual timers to create.
 *
 * @author Cory Sharp <cssharp@eecs.berkeley.edu>
 */

generic module VirtualizeTimer16C(typedef precision_tag, int max_timers) @safe()
{
  provides interface Timer16<precision_tag> as Timer16[uint8_t num];
  uses interface Timer16<precision_tag> as TimerFrom;
}
implementation
{
  enum
    {
      NUM_TIMERS = max_timers,
      END_OF_LIST = 255,
    };

  typedef struct
  {
    uint16_t t0;
    uint16_t dt;
    bool isoneshot : 1;
    bool isrunning : 1;
    bool _reserved : 6;
  } Timer_t;

  Timer_t m_timers[NUM_TIMERS];
  bool m_timers_changed;

  task void updateFromTimer();

  void fireTimers(uint16_t now)
  {
    uint8_t num;

    for (num=0; num<NUM_TIMERS; num++)
      {
	Timer_t* timer = &m_timers[num];

	if (timer->isrunning)
	  {
	    uint16_t elapsed = now - timer->t0;

	    if (elapsed >= timer->dt)
	      {
		if (timer->isoneshot)
		  timer->isrunning = FALSE;
		else // Update timer for next event
		  timer->t0 += timer->dt;

		signal Timer16.fired[num]();
    break;
	      }
	  }
      }
    post updateFromTimer();
  }
  
  task void updateFromTimer()
  {
    /* This code supports a maximum dt of MAXINT. If min_remaining and
       remaining were switched to uint16_t, and the logic changed a
       little, dt's up to 2^16-1 should work (but at a slightly higher
       runtime cost). */
    uint16_t now = call TimerFrom.getNow();
    int16_t min_remaining = (1U << 15) - 1; /* max int16_t */
    bool min_remaining_isset = FALSE;
    uint8_t num;

    call TimerFrom.stop();

    for (num=0; num<NUM_TIMERS; num++)
      {
	Timer_t* timer = &m_timers[num];

	if (timer->isrunning)
	  {
	    uint16_t elapsed = now - timer->t0;
	    int16_t remaining = timer->dt - elapsed;

	    if (remaining < min_remaining)
	      {
		min_remaining = remaining;
		min_remaining_isset = TRUE;
	      }
	  }
      }

    if (min_remaining_isset)
      {
	if (min_remaining <= 0)
	  fireTimers(now);
	else
	  call TimerFrom.startOneShotAt(now, min_remaining);
      }
  }
  
  event void TimerFrom.fired()
  {
    fireTimers(call TimerFrom.getNow());
  }

  void startTimer(uint8_t num, uint16_t t0, uint16_t dt, bool isoneshot)
  {
    Timer_t* timer = &m_timers[num];
    timer->t0 = t0;
    timer->dt = dt;
    timer->isoneshot = isoneshot;
    timer->isrunning = TRUE;
    post updateFromTimer();
  }

  command void Timer16.startPeriodic[uint8_t num](uint16_t dt)
  {
    startTimer(num, call TimerFrom.getNow(), dt, FALSE);
  }

  command void Timer16.startOneShot[uint8_t num](uint16_t dt)
  {
    startTimer(num, call TimerFrom.getNow(), dt, TRUE);
  }

  command void Timer16.stop[uint8_t num]()
  {
    m_timers[num].isrunning = FALSE;
  }

  command bool Timer16.isRunning[uint8_t num]()
  {
    return m_timers[num].isrunning;
  }

  command bool Timer16.isOneShot[uint8_t num]()
  {
    return m_timers[num].isoneshot;
  }

  command void Timer16.startPeriodicAt[uint8_t num](uint16_t t0, uint16_t dt)
  {
    startTimer(num, t0, dt, FALSE);
  }

  command void Timer16.startOneShotAt[uint8_t num](uint16_t t0, uint16_t dt)
  {
    startTimer(num, t0, dt, TRUE);
  }

  command uint16_t Timer16.getNow[uint8_t num]()
  {
    return call TimerFrom.getNow();
  }

  command uint16_t Timer16.gett0[uint8_t num]()
  {
    return m_timers[num].t0;
  }

  command uint16_t Timer16.getdt[uint8_t num]()
  {
    return m_timers[num].dt;
  }

  default event void Timer16.fired[uint8_t num]()
  {
  }
}

