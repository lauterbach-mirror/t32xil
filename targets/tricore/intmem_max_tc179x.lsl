
//        TRACE32 Integration for Simulink
//    Copyright (c) 2012-2015 Lauterbach GmbH
//              All rights reserved


#define INTTAB 0xC0003000
#define RESET  0xC0000000
#define TRAPTAB (INTTAB + 0x10)

#if defined(__PROC_TC1791__)
#define __REDEFINE_ON_CHIP_ITEMS 
#include "tc1791.lsl"
processor mpe
{
    derivative = my_tc1791;
}
derivative my_tc1791 extends tc1791
{
    memory pflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80000000, size=2M);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0000000, size=2M, reserved);
    }
    memory pflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 2M;
        priority = 2;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x80800000, size=2M);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xa0800000, size=2M, reserved);
    }
    memory dflash0 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 96k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xaf000000, size=96k);
    }
    memory dflash1 (tag="on-chip")
    {
        mau = 8;
        type = reserved nvram;
        size = 96k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xaf080000, size=96k);
    }
    memory lmuram (tag="on-chip")
    {
        mau = 8;
        type = reserved ram;
        size = 128k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x90000000, size=128k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xb0000000, size=128k, reserved);
    }
    memory brom (tag="on-chip")
    {
        mau = 8;
        type = reserved rom;
        size = 16k;
        map cached(dest=bus:tc:fpi_bus, dest_offset=0x8fffc000, size=16k);
        map not_cached(dest=bus:tc:fpi_bus, dest_offset=0xafffc000, size=16k, reserved);
    }
    memory dspr (tag="on-chip")
    {
        mau = 8;
        type = ram;
        size = 128k;
        priority = 2;
        map (dest=bus:tc:fpi_bus, dest_offset=0xd0000000, size=128k);
    }
    memory pspr (tag="on-chip")
    {
        mau = 8;
        type = reserved ram;
        size = 32k;
        map (dest=bus:tc:fpi_bus, dest_offset=0xc0000000, size=32k);
        map (dest=bus:tc:fpi_bus, dest_offset=0xc8000000, size=32k);
    }
    memory pram (tag="on-chip")
    {
        mau = 8;
        write_unit = 4;
        type = reserved ram;
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
