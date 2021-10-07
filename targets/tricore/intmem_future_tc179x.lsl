
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define RESET 0xD4000000
#define INTTAB 0xD4005000
#define TRAPTAB 0xD4005010

#if defined(__PROC_TC1797__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc1797.lsl"
processor spe
{
    derivative = my_tc1797;
}
derivative my_tc1797 extends tc1797
{
    memory pflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80000000, size=2M, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0000000, size=2M);
    }
    memory pflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80200000, size=2M, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0200000, size=2M);
    }
    memory dflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 32k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe00000, size=32k, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe00000, size=32k);
    }
    memory dflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 32k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe10000, size=32k, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe10000, size=32k);
    }
    memory ovram (tag="on-chip")
    {
        mau = 8;
        type = reserved ram;
        size = 8k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe80000, size=8k, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe80000, size=8k);
    }
    memory brom (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 16k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fffc000, size=16k, reserved);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafffc000, size=16k);
    }
    memory ldram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 124k;
        priority = 2;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd0000000, size=124k);
    }
    memory spram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 24k;
        exec_priority = 8;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd4000000, size=24k);
    }
    memory pram (tag="on-chip")
    {
        mau = 8;
        write_unit = 4;
        type = ram;
        size = 16k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xf0050000, size=16k);
        map (dest=bus:tc:pcp_data_bus, size=16k);
    }
    memory pcode (tag="on-chip")
    {
        mau = 8;
        write_unit = 4;
        type = ram;
        size = 32k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xf0060000, size=32k);
        map (dest=bus:tc:pcp_code_bus, size=32k);
    }
}
#else
#include <cpu.lsl>
#endif

memory xram_8_a (tag="on-board")
{
    mau = 8;
    type = reserved ram;
    size = 1M;
    map cached(dest=bus:spe:fpi_bus, dest_offset=0x82000000, size=1M, reserved);
    map not_cached(dest=bus:spe:fpi_bus, dest_offset=0xa2000000, size=1M);
}
memory flash0 (tag="AM29BL162C", tag="on-board")
{
    mau = 8;
    type = reserved rom;
    size = 2M*2;
    map (dest=bus:spe:fpi_bus, dest_offset=0xa1000000, size=2M*2);
}
