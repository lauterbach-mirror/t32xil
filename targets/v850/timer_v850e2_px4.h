/*! \file timer_v850e2_px4.h
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
 * $Id: timer_v850e2_px4.h 1272 2016-06-23 15:37:54Z csax $      
 */
 
#ifndef TIMER_V850E2_PX4_H
#define TIMER_V850E2_PX4_H
 
unsigned long HardwareTimer(void);
 
#endif