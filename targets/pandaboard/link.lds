MEMORY 
{
	FLASH : ORIGIN = 0x0, LENGTH = 4M
	SRAM  : ORIGIN = 0x40300000, LENGTH = 512K
}

ENTRY(_start)

SECTIONS
{
    .isr_vector :
    {
        __isr_base = . ;
        . = ALIGN(0x20);
        KEEP(*(.isr_vector))
    } > SRAM =0x00

    .text :
    {
        . = ALIGN(0x40);
        KEEP(*(.text.crt*))
        *(.text*)
        . = ALIGN(4);
        _etext = .;
    } > SRAM

    .eh_frame_hdr : ALIGN (4)
    {
        KEEP (*(.eh_frame_hdr))
        *(.eh_frame_entry .eh_frame_entry.*)
    } > SRAM
    .eh_frame : ALIGN (4)
    {
        KEEP (*(.eh_frame)) *(.eh_frame.*)
    } > SRAM
    .ARM.exidx : 
    {
        __exidx_start = .;
        KEEP(*(.ARM.exidx*))
        KEEP(*(.gnu.linkonce.armexidx.*))
        __exidx_end = .;
    } > SRAM

    .rodata :
    {
        *(.rodata*)
        *(.constdata*)
        . = ALIGN(4);
    } > SRAM

    .data : 
    {
        __init_array_start = .;
        __init_array_end = .;
        __data_start = . ;
        __data = .;
        *(vtable*)
        *(.data*)
	. = ALIGN(4);
        __data_end = .;
    } > SRAM

    .bss : ALIGN(6) {
        __bss_start = .;
        * (.sbss)
        * (.bss*)
        * (COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > SRAM

    .stack :
    {
        . = ALIGN(0x8);
        __stack_start = .;
        . += 0x200;
        __stack_end = .;
    } > SRAM

    __heap_start = .;

    .stack_mp (0x40300000+32K-3*0x200) :
    {
        __stack_start_mp = .;
        . += 3*0x200;
        __stack_end_mp = .;
    } > SRAM
	
}

__SRAM_start = ORIGIN(SRAM);
__SRAM_size  = LENGTH(SRAM);
__data_vaddr = ADDR(.data);
__data_laddr = LOADADDR(.data);
__data_size  = SIZEOF(.data);
__stack_size = 0x200;
