#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

#ifndef __PRIORITY__
#define __PRIORITY__ 1
#endif

#ifndef __SHARE__
#define __SHARE__ 2
#endif

#ifndef __LOTTERY_TICKETS__
#define __LOTTERY_TICKETS__ 4
#endif

// comment out to enable alternative sync method
#define __PRINT_METHOD_LOCK__

void
start(void)
{
	int i;
	
	sys_set_priority(__PRIORITY__);
	sys_set_share(__SHARE__);
	sys_set_lottery_tickets(__LOTTERY_TICKETS__);

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.

		#ifdef __PRINT_METHOD_LOCK__

		while(atomic_swap(&lock, 1) != 0) 
			continue;
		*cursorpos++ = PRINTCHAR;
		atomic_swap(&lock, 0);
		
		#else
		
		sys_atomic_print(PRINTCHAR);

		#endif

		sys_yield();
	}

	// Yield forever.
	//while (1)
	//	sys_yield();
	sys_exit(0);
}
