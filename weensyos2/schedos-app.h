#ifndef WEENSYOS_SCHEDOS_APP_H
#define WEENSYOS_SCHEDOS_APP_H
#include "schedos.h"

/*****************************************************************************
 * schedos-app.h
 *
 *   System call functions and constants used by SchedOS applications.
 *
 *****************************************************************************/


// The number of times each application should run
#define RUNCOUNT	320


/*****************************************************************************
 * sys_yield
 *
 *   Yield control of the CPU to the kernel, which will pick another
 *   process to run.  (It might run this process again, depending on the
 *   scheduling policy.)
 *
 *****************************************************************************/

static inline void
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
		     : : "i" (INT_SYS_YIELD)
		     : "cc", "memory");
}


/*****************************************************************************
 * sys_exit(status)
 *
 *   Exit the current process with exit status 'status'.
 *
 *****************************************************************************/

static inline void sys_exit(int status) __attribute__ ((noreturn));
static inline void
sys_exit(int status)
{
	// Different system call, different interrupt number (INT_SYS_EXIT).
	// This time, we also pass an argument to the system call.
	// We do this by loading the argument into a known register; then
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
		     : : "i" (INT_SYS_EXIT),
		         "a" (status)
		     : "cc", "memory");
    loop: goto loop; // Convince GCC that function truly does not return.
}

/*****************************************************************************
* sys_set_priority(priority)
* 
* Sets priority of current process with priority number 'priority'.
*
******************************************************************************/

static inline void
sys_set_priority(int priority) {
	// Interrupt number provided in skeleton (INT_SYS_USER1).
	// pass argument to system call by loading into known regiser; then
	// the kernel can look up the register value to read the argument.
	// Here, the priority is read into register %eax.
	asm volatile("int %0\n"
		    : : "i" (INT_SYS_USER1),
			"a" (priority)
		    : "cc", "memory");
}

/*****************************************************************************
* sys_set_share(share)
*
* Sets share of current process with share number 'share'.
*
******************************************************************************/

static inline void
sys_set_share(int share) {
	// Interrupt number provided in skeleton (INT_SYS_USER2).
	// pass argument to system call by loading into known register; then
	// the kernel can look up the register value to read the argument.
	// Here, the share is read into register %eax.
	asm volatile("int %0\n"
		    : : "i" (INT_SYS_USER2),
			"a" (share)
		    : "cc", "memory");
}

/*****************************************************************************
* sys_atomic_print(c)
*
* Allows for atomic printing and thus process sync by moving print to kernel
* space.
*
******************************************************************************/

static inline void
sys_atomic_print(int c) {
	// Uses new interrupt number (INT_SYS_ATOMIC_PRINT).
	// pass argument to system call by loading into known register; then
	// the kernel can look up the register value to read the argument and
	// print that value. Here, the 'c' is read into register %eax.
	asm volatile("int %0\n"
		    : : "i" (INT_SYS_ATOMIC_PRINT),
			"a" (c)
		    : "cc", "memory");
}

/*****************************************************************************
* sys_set_lottery_tickets(n)
*
* Sets num_tickets of the current process to 'n'.
*
******************************************************************************/

static inline void
sys_set_lottery_tickets(int n) {
	// uses new interrupt number (INT_SYS_SET_LOTTERY)
	// pass argument to system call by loading into known register; then
	// the kernel can look up the register value to read the argument and
	// assign it to p_num_tickets. Here, the 'n' is read into
	// register %eax.
	asm volatile("int %0\n"
		    : : "i" (INT_SYS_SET_LOTTERY),
			"a" (n)
		    : "cc", "memory");
}

#endif
