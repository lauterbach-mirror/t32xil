
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define RESET 0xD4000000
#define INTTAB 0xD4001800
#define TRAPTAB (INTTAB + 0x10)

#if defined(__PROC_TC1724__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc1724.lsl"
processor spe
{
    derivative = my_tc1724;
}
derivative my_tc1724 extends tc1724
{
    memory pflash (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 1536k;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80000000, size=1536k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0000000, size=1536k, reserved);
    }
    memory dflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 32k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe00000, size=32k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe00000, size=32k, reserved);
    }
    memory dflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 32k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe10000, size=32k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe10000, size=32k, reserved);
    }
    memory ovram (tag="on-chip")
    {
        mau = 8;
        type = reserved ram;
        size = 8k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe80000, size=8k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe80000, size=8k, reserved);
    }
    memory brom (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 16k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fffc000, size=16k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafffc000, size=16k, reserved);
    }
    memory ldram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 116k;
        priority = 2;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd0000000, size=116k);
    }
    memory spram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 16k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd4000000, size=16k);
    }
    memory pram (tag="on-chip")
    {
        mau = 8;
        write_unit = 4;
        type = ram;
        size = 8k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xf0050000, size=8k);
        map (dest=bus:tc:pcp_data_bus, size=8k);
    }
    memory pcode (tag="on-chip")
    {
        mau = 8;
        write_unit = 4;
        type = reserved ram;
        size = 24k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xf0060000, size=24k);
        map (dest=bus:tc:pcp_code_bus, size=24k);
    }
}
#else
#include <cpu.lsl>
#endif

section_layout ::linear
{
    group heap "heap" (size = 4k,tag="user");
}
