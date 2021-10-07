
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define TRAPTAB 0x70101700
#define TRAPTAB0 TRAPTAB
#define INTTAB0 (TRAPTAB0+0x100)
#define INTTAB INTTAB0
#define TRAPTAB1 0x60101F00
#define INTTAB1 (TRAPTAB1 + 0x100)
#define RESET 0x70100000

#if defined(__PROC_TC23X__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc23x.lsl"
processor mpe
{
    derivative = my_tc23x;
}
derivative my_tc23x extends tc23x
{
    memory dspr0 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 184k;
        priority = 2;
        map (dest=bus:tc0:fpi_bus, dest_offset=0xd0000000, size=184k, priority=8);
        map (dest=bus:sri, dest_offset=0x70000000, size=184k);
    }
    memory pspr0 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 8k;
        exec_priority=17;
        map (dest=bus:tc0:fpi_bus, dest_offset=0xc0000000, size=8k, priority=4,exec_priority=16);
        map (dest=bus:sri, dest_offset=0x70100000, size=8k);
    }
    memory pflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        map cached(dest=bus:sri, dest_offset=0x80000000, size=2M);
        map not_cached(dest=bus:sri, dest_offset=0xA0000000, size=2M, reserved);
    }
    memory brom (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 32k;
        map cached(dest=bus:sri, dest_offset=0x8fff8000, size=32k);
        map not_cached(dest=bus:sri, dest_offset=0xafff8000, size=32k, reserved);
    }
    memory dflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 384k+16k;
        map (dest=bus:sri, src_offset=0, dest_offset=0xaf000000, size=384k);
        map (dest=bus:sri, src_offset=384k, dest_offset=0xaf100000, size=16k);
    }
    memory dflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 64k;
        map (dest=bus:sri, dest_offset=0xaf110000, size=64k);
    }
}
#else
#include <cpu.lsl>
#endif
