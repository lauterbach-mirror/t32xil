
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define INTTAB0 0x70103000
#define INTTAB INTTAB0
#define INTTAB1 0x60103000
#define TRAPTAB (INTTAB + 0x10)
#define TRAPTAB0 TRAPTAB
#define TRAPTAB1 (INTTAB1 + 0x10)
#define INTTAB2 0x50103000
#define TRABTAB2 (INTTAB2 + 0x10)
#define RESET 0x70100000

#if defined(__PROC_TC27XB__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc27x.lsl"
processor mpe
{
    derivative = my_tc27x;
}
derivative my_tc27x extends tc27x
{
    memory dspr0 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 120k;
        priority = 2;
        map (dest=bus:tc0:fpi_bus, dest_offset=0xd0000000, size=112k, priority=8);
        map (dest=bus:sri, dest_offset=0x70000000, size=112k);
    }
    memory pspr0 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 32k;
        exec_priority=17;
        map (dest=bus:tc0:fpi_bus, dest_offset=0xc0000000, size=24k, priority=4,exec_priority=16);
        map (dest=bus:sri, dest_offset=0x70100000, size=24k);
    }
    memory dspr1 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 240k;
        map (dest=bus:tc1:fpi_bus, dest_offset=0xd0000000, size=120k, priority=8);
        map (dest=bus:sri, dest_offset=0x60000000, size=120k);
    }
    memory pspr1 (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 32k;
        exec_priority=16;
        map (dest=bus:tc1:fpi_bus, dest_offset=0xc0000000, size=32k, priority=4,exec_priority=16);
        map (dest=bus:sri, dest_offset=0x60100000, size=32k);
    }
    memory dspr2 (tag="on-chip")
    {
    	mau = 8;
	type = ram;
	size = 240k;
	map (dest=bus:tc2:fpi_bus, dest_offset=0xd0000000, size=120k, priority=8);
	map (dest=bus:sri, dest_offset=0x50000000, size=120k);
    }
    memory pspr2 (tag="on-chip")
    {
	mau = 8;
	type = ram;
	size = 32k;
	exec_priority=16;
	map (dest=bus:tc2:fpi_bus, dest_offset=0xc0000000, size=32k, priority=4,exec_priority=16);
	map (dest=bus:sri, dest_offset=0x50100000, size=32k);
    }
    memory pflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        map cached(dest=bus:sri, dest_offset=0x80000000, size=2M);
        map not_cached(dest=bus:sri, dest_offset=0xA0000000, size=2M, reserved);
    }
    memory pflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        map cached(dest=bus:sri, dest_offset=0x80200000, size=2M);
        map not_cached(dest=bus:sri, dest_offset=0xA0200000, size=2M, reserved);
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

    memory lmuram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 32k;
        map cached(dest=bus:sri, dest_offset=0x90000000, size=32k, reserved);
        map not_cached(dest=bus:sri, dest_offset=0xb0000000, size=32k);
    }
}
#else
#include <cpu.lsl>
#endif
