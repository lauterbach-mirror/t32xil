
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define RESET 0xD4000000
#define INTTAB 0xD4001800
#define TRAPTAB (INTTAB + 0x10)

#if defined(__PROC_TC1782__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc1782.lsl"
processor spe
{
    derivative = my_tc1782;
}
derivative my_tc1782 extends tc1782
{
    memory pflash (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2500k;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80000000, size=2500k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0000000, size=2500k, reserved);
    }
    memory dflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 64k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe00000, size=64k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe00000, size=64k, reserved);
    }
    memory dflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 64k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fe10000, size=64k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafe10000, size=64k, reserved);
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
        size = 124k;
        priority = 2;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd0000000, size=124k);
    }
    memory spram (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 24k;
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
        type = reserved ram;
        size = 32k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xf0060000, size=32k);
        map (dest=bus:tc:pcp_code_bus, size=32k);
    }
}
#else
#include <cpu.lsl>
#endif

section_layout ::linear
{
    group heap "heap" (size = 32k,tag="user");
}
