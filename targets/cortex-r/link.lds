MEMORY 
{
	FLASH : ORIGIN = 0x0, LENGTH = 4M
	DRAM  : ORIGIN = 0x08000000, LENGTH = 512K
}

ENTRY(_start)

SECTIONS
{
	.text : {
		* (.text)
	} > DRAM

	.rodata : ALIGN(6) {
		* (.rodata)
	} > DRAM

	.data : ALIGN(6) {
		__init_array_start = .;
		__init_array_end = .;
		* (.data)
		* (.sdata)
	} > DRAM 

	.bss : ALIGN(6) {
		__bss_start = .;
		* (.sbss)
		* (.bss*)
		* (COMMON)
		. = ALIGN(4);
		__bss_end = .;
	} > DRAM


	__heap_start = .;
}

__stack_end  = ORIGIN(DRAM)+LENGTH(DRAM);
__DRAM_start = ORIGIN(DRAM);
__DRAM_size  = LENGTH(DRAM);
__data_vaddr = ADDR(.data);
__data_laddr = LOADADDR(.data);
__data_size  = SIZEOF(.data);
