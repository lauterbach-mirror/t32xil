MEMORY
{
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

ENTRY(_start)

SECTIONS
{
    .isr_vector :
    {
        __nvic_base = . ;
        . = ALIGN(4);
        KEEP(*(.exception_vector))
        . = ABSOLUTE(__nvic_base) + 0x40;
        KEEP(*(.isr_vector))
        . = ABSOLUTE(__nvic_base) + 0x400;
    } > SRAM =0x00
    .gnu.sgstubs : ALIGN (0x10)
    {
        __sg_start = .;
        KEEP(*(.gnu.sgstubs));
        . = ALIGN(0x10);
        __sg_end = .;
    } > SRAM
    .text :
    {
        . = ALIGN(4);
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
    } > SRAM
    .data :
    {
        __data_start = . ;
        __data = .;
        *(vtable*)
        *(.data*)
 . = ALIGN(4);
        __data_end = .;
    } > SRAM AT> SRAM
    .init : ALIGN(0x4)
    {
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP (*(.preinit_array))
        KEEP (*(.init))
        KEEP (*(SORT(.init_array.*)))
        KEEP (*(.init_array))
        PROVIDE_HIDDEN (__init_array_end = .);
    } > SRAM AT> SRAM
    .bss : ALIGN(6) {
        __bss_start = .;
        * (.sbss*)
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
        __stack_end = ABSOLUTE(.)&~(0x7);
    } > SRAM
    .mtb ALIGN(0x40):
    {
        __mtb_start = .;
        . += 0x40;
        __mtb_end = .;
    } > SRAM
    __heap_start = .;
}
__SRAM_start = ORIGIN(SRAM);
__SRAM_size = LENGTH(SRAM);
__data_vaddr = ADDR(.data);
__data_laddr = LOADADDR(.data);
__data_size = SIZEOF(.data);
__init_vaddr = ADDR(.init);
__init_laddr = LOADADDR(.init);
__init_size = SIZEOF(.init);
