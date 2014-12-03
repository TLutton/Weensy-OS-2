/*****************************************************************************
 * schedos-3
 *
 *   See schedos-1.
 *
 *****************************************************************************/

#define PRINTCHAR	('3' | 0x0900)

#define __PRIORITY__ 1

#define __SHARE__ 8

#define __LOTTERY_TICKETS__ 4

// comment out to enable alternative sync method
#define __PRINT_METHOD_LOCK__

#include "schedos-1.c"
