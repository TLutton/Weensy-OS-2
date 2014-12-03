/*****************************************************************************
 * schedos-4
 *
 *   See schedos-1.
 *
 *****************************************************************************/

#define PRINTCHAR	('4' | 0x0E00)

#define __PRIORITY__ 4

#define __SHARE__ 4

#define __LOTTERY_TICKETS__ 4

// comment out to enable alternative sync method
#define __PRINT_METHOD_LOCK__

#include "schedos-1.c"
