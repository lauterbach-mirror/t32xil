/*! \file t32xil_rtiostream.c
 * @Title:  Target-side rtiostream communication channel
 * @Description:
 *   Source code implementation of the target-side rtiostream driver. The code
 *   is automatically included in the code of the PIL harness running on the
 *   target.
 * @Keywords: MATLAB Simulink PIL processor-in-the-loop t32xil
 * @Author: MBU
 * @Copyright: (C) 1989-2016 Lauterbach GmbH, licensed for use with TRACE32(R) only
 * --------------------------------------------------------------------------------
 * $Id: t32xil_rtiostream.c 1272 2016-06-23 15:37:54Z csax $      
 */


#include <stddef.h>
#include "rtwtypes.h"

#define T32_T2H_BUFFERSIZE  256
#define T32_H2T_BUFFERSIZE  256

volatile uint32_T  T32_Endianness = 0x76543200;
volatile uint8_T   T32_T2H_Size = 0;
volatile uint8_T   T32_H2T_Size = 0;
volatile uint8_T   T32_T2H_Buffer[T32_T2H_BUFFERSIZE];
volatile uint8_T   T32_H2T_Buffer[T32_H2T_BUFFERSIZE];

int rtIOStreamOpen( int argc, void *argv[]);
int rtIOStreamClose(int streamID);
int rtIOStreamSend( int streamID, const void *src, size_t size, size_t *sizeSent);
int rtIOStreamRecv( int streamID,       void *dst, size_t size, size_t *sizeRecvd);

int rtIOStreamOpen(int argc, void *argv[])
{
    T32_Endianness = 0x65432100;
    T32_T2H_Size = 0;
    T32_H2T_Size = 0;
    return 1;
}

int rtIOStreamClose(int streamID)
{
    return 0;
}

int rtIOStreamSend(int streamID, const void *src, size_t size, size_t *sizeSent)
{
    size_t i;

    while (T32_T2H_Size != 0);

    for (i = 0; i < size; i++)
        T32_T2H_Buffer[i] = ((const uint8_T *)src)[i];

    T32_T2H_Size = (uint8_T) size;
    *sizeSent = size;

    return 0;
}

int rtIOStreamRecv(int streamID, void *dst, size_t size, size_t *sizeRecvd)
{
    static size_t  offset = 0;
    size_t         i, n;

    if (T32_H2T_Size == 0) {
        *sizeRecvd = 0;
    }
    else {
        if (size >= (size_t) T32_H2T_Size)
            n = (size_t) T32_H2T_Size;
        else
            n = size;

        for (i = 0; i < n; i++)
            ((uint8_T *)dst)[i] = T32_H2T_Buffer[i + offset];

        if (size >= (size_t) T32_H2T_Size)
            offset = 0;
        else
            offset += size;

        T32_H2T_Size -= (uint8_T) n;
        *sizeRecvd = n;
    }

    return 0;
}
