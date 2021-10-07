/*! \file timer_v850e2_px4.c
 * @Title: Timer for code execution profiling
 * @Description:
 *   Access to an hardware timer for runtime measurements via code instrumentation.
 *   The source code is automatically included in the PIL harness running on the
 *   target. Uses the OS Timer OSTM0.
 * @Keywords: MATLAB Simulink PIL processor-in-the-loop t32xil
 * @Author: CSA
 * @Board: V850*
 * @Chip: V850E2/Px4
 * @Copyright: (C) 1989-2016 Lauterbach GmbH, licensed for use with TRACE32(R) only
 * --------------------------------------------------------------------------------
 * $Id: timer_v850e2_px4.c 1273 2016-06-24 07:09:22Z csax $      
 */
 
 
#include "timer_v850e2_px4.h"

/* OS Timer (OSTM) */
#define OSTM0_BASE0_ADDRESS  0xff800000UL
#define OSTM0_BASE1_ADDRESS  0xffffc000UL
#define OSTM0_BASE1_CNT_OFFSET  0x4UL
#define OSTM0_BASE1_TE_OFFSET  0x10UL
#define OSTM0_BASE1_TS_OFFSET  0x14UL
#define OSTM0_BASE1_TT_OFFSET  0x18UL
#define OSTM0_BASE0_CTL_OFFSET  0x20UL
#define OSTM0_IC0CKSEL0  0xff83f000UL


/*! \brief Count ticks of PCLK
 *
 * Initializes and starts the counter OSTM0 on the first run.
 * \returns Counter value
 */ 
unsigned long HardwareTimer(void)
{
	unsigned long *register_address = 0;
	unsigned long counter_value = 0;
	static unsigned char is_initialized = 0;
	
	if (is_initialized == 0) {	
		/* Stop the counter */
		register_address = (unsigned long*) (OSTM0_BASE1_ADDRESS + OSTM0_BASE1_TT_OFFSET);
		*register_address = 1;
		
		/* Select peripheral clock (PCLK) as clock source */
		register_address = (unsigned long*) OSTM0_IC0CKSEL0;
		*register_address = 0;
	
		/* Select free-running comparison mode (counter is counting upwards) */
		register_address = (unsigned long*) (OSTM0_BASE0_ADDRESS + OSTM0_BASE0_CTL_OFFSET);
		*register_address = 2;
	
		/* Start the counter */
		register_address = (unsigned long*) (OSTM0_BASE1_ADDRESS + OSTM0_BASE1_TS_OFFSET);
		*register_address = 1;
		
		is_initialized = 1;
	}
	
	/* Read the counter value */
	register_address = (unsigned long*) (OSTM0_BASE1_ADDRESS + OSTM0_BASE1_CNT_OFFSET);
	counter_value = *register_address;
	
	return counter_value;
}
