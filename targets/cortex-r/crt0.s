.section .text
.globl  _start
.globl  _exit


#ifdef __thumb__
# define subs sub
#endif


_start:
	/* set stack and frame pointer */
	ldr  	r1, .SP
	mov  	r0, #3
	bic	    r1, r0 
	mov  	r0, #0
	mov  	sp, r1
	mov  	fp, r0

	/* clear .bss-section */
	ldr  	r4, .BSS_S
	ldr  	r5, .BSS_E
	subs 	r5, r5, r4
	beq  	bss_done
	mov  	r0, #0
bss_clear:
	strb 	r0, [r4]
	add  	r4, r4, #1
	subs 	r5, r5, #1
	bne  	bss_clear
bss_done:

	/* initialization of e.g. static objects */
	ldr  	r4, .INIT_S
	ldr  	r5, .INIT_E
	subs 	r5, r5, r4
	beq  	init_done
init:
	ldr  	r3,[r4]
	push 	{r0,r5}
	mov  	r14,pc
	bx   	r3
	pop  	{r0,r5}
	add  	r4, r4, #4
	subs 	r5, r5, #4
	bne  	init
init_done:

gomain:
	mov  	r0, #0
	mov  	r1, #0
	bl   	main

_exit:
	b    	_exit


.align  2
.SP:
	.word	__stack_end
.BSS_S:
	.word	__bss_start
.BSS_E:
	.word	__bss_end
.INIT_S:
	.word	__init_array_start
.INIT_E:
	.word	__init_array_end
.DATA_S:
	.word	__data_vaddr
.DATA_LADDR:
	.word	__data_laddr
.DATA_SIZE:
	.word	__data_size

