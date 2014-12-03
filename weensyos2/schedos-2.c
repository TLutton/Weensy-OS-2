/*****************************************************************************
 * schedos-2
 *
 *   See schedos-1.
 *
 *****************************************************************************/

#define PRINTCHAR	('2' | 0x0A00)

#define __PRIORITY__ 2

#define __SHARE__ 4

// comment out to enable alternative sync method
#define __PRINT_METHOD_LOCK__

#include "schedos-1.c"
