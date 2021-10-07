
MEMORY
{
	rom:	   org= 0x00000000,  len= 0x30000   	/* program */
	ram:	   org= 0x40000000,  len= 0x40000  	/* data */
}

SECTIONS
{
    /* Collect all code sections from all input files to make a single output
     * .text section and locate it in "rom1" memory (except for .text2 code
     * sections).                                                            */

    GROUP : {
            .text_vle : { *(.text) *(.init) *(.fini) }
            .ctors (=TEXT) ALIGN(4):{ ctordtor.o(.ctors) *(.ctors) } 
            .dtors (=TEXT) ALIGN(4):{ ctordtor.o(.dtors) *(.dtors) }
            .sdata2 : {}
            __DATA_ROM	= .;
    } > rom

    /* Collect initialized data sections (.data) from all input files to make
     * a single output .data section. Reserve space for the .data section in
     * "ram" memory (via "> ram"). However use the LOAD clause to place the
     * actual data after the ".text2" section in the "rom2" memory.
     * __init_main() will move the actual data from "rom2" to "ram".
     *
     * Reserve space for all .bss sections in "ram" memory after the .data
     * section. Any remaining space will be used as heap by malloc().
     *
     * The GROUP command guarantees that sections will be kept together
     * and in the order given.                                               */

    GROUP : {
	__DATA_RAM	= .;

	/* With the LOAD specification, the next command will
	 * reserve space for the .data section at the beginning of
	 * "ram" (the "logical" address), but actually place the
	 * data in the image at the end of the .text section as
	 * defined by __DATA_ROM in the GROUP above (the "physical"
	 * address).
	 */
	.data LOAD(__DATA_ROM) : {}
	.sdata (DATA) LOAD(ADDR(.sdata) - ADDR(.data) + __DATA_ROM) : {}

	__DATA_END	= .;

	/* Allocate uninitialized sections.			    */

	__BSS_START	= .;
	.sbss : {}
        .bss  : {}
	__BSS_END	= .;

	/* Any remaining space will be used as a heap.		    */

	__HEAP_START	= .;
    } > ram
}

/* Definitions of identifiers used by sbrk.c, init.c and the different
 * crt0.s files. Their purpose is to control initialization and memory
 * memory allocation.
 *
 * __HEAP_START : Used by sbrk.c: start of memory used by malloc() etc.
 * __HEAP_END   : Used by sbrk.c: end of heap memory
 * __SP_INIT    : Used by crt0.s: initial address of stack pointer
 * __SP_END     : Used by sbrk.c: only used when stack probing
 * __DATA_ROM   : Used by init.c: start of initialized data in ROM
 * __DATA_RAM   : Used by init.c: start of initialized data in RAM
 * __DATA_END   : Used by init.c: end of initialized data in RAM
 * __BSS_START  : Used by init.c: start of uninitialized data
 * __BSS_END    : Used by init.c: end of data to be cleared
 * ------------------------------------------------------------------------- */

__SP_INIT	= ADDR(ram)+SIZEOF(ram)-8;
__SP_END	= __SP_INIT-0x7F8;
__HEAP_END	= __SP_END-8;
