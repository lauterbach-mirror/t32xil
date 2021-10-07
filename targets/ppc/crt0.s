# Start-up function for an embedded environment

	.file		"crt0.c"
	.text
	.globl		_start
	.globl		_start_core1
        .globl          l1csr0_write
        .globl          l1csr1_write
        .globl          bucsr_write
	.globl		GetProcessorID

	.org 0x00000000
	.if	use_vle
	.long 0x015a0000
	.elsec
	.long 0x005a0000
	.endc
	.long _start
	
	.align		2
_tlbdata:	
	.if	use_vle
	.long 0x10000000
	.long 0x80000600
	.long 0x00000020
	.long 0x0000003F
	.elsec
	.long 0x10000000
	.long 0x80000600
	.long 0x00000000
	.long 0x0000003F
	.endc
	.long 0x10010000
	.long 0x80000400
	.long 0x40000000
	.long 0x4000003F

_start:
        li 		r0,0
        li 		r1,0
        li 		r2,0
        li 		r3,0
        li 		r4,0
        li 		r5,0
        li 		r6,0
        li 		r7,0
        li 		r8,0
        li 		r9,0
        li 		r10,0
        li 		r11,0
        li 		r12,0
        li 		r13,0
        li 		r14,0
        li 		r15,0
        li 		r16,0
        li 		r17,0
        li 		r18,0
        li 		r19,0
        li 		r20,0
        li 		r21,0
        li 		r22,0
        li 		r23,0
        li 		r24,0
        li 		r25,0
        li 		r26,0
        li 		r27,0
        li 		r28,0
        li 		r29,0
        li 		r30,0
        li 		r31,0
_init_int_vectors:
        addis           r2,r0,IVOR0_handler@ha
        addi            r2,r11,IVOR0_handler@l
	mtivpr		r2
	mtivor0		r2
        addis           r2,r0,IVOR1_handler@ha
        addi            r2,r11,IVOR1_handler@l
	mtivor1		r2
        addis           r2,r0,IVOR2_handler@ha
        addi            r2,r11,IVOR2_handler@l
	mtivor2		r2
        addis           r2,r0,IVOR3_handler@ha
        addi            r2,r11,IVOR3_handler@l
	mtivor3		r2
        addis           r2,r0,IVOR4_handler@ha
        addi            r2,r11,IVOR4_handler@l
	mtivor4		r2
        addis           r2,r0,IVOR5_handler@ha
        addi            r2,r11,IVOR5_handler@l
	mtivor5		r2
        addis           r2,r0,IVOR6_handler@ha
        addi            r2,r11,IVOR6_handler@l
	mtivor6		r2
        addis           r2,r0,IVOR7_handler@ha
        addi            r2,r11,IVOR7_handler@l
	mtivor7		r2
        addis           r2,r0,IVOR8_handler@ha
        addi            r2,r11,IVOR8_handler@l
	mtivor8		r2
        addis           r2,r0,IVOR9_handler@ha
        addi            r2,r11,IVOR9_handler@l
	mtivor9		r2
        addis           r2,r0,IVOR10_handler@ha
        addi            r2,r11,IVOR10_handler@l
	mtivor10	r2
        addis           r2,r0,IVOR11_handler@ha
        addi            r2,r11,IVOR11_handler@l
	mtivor11	r2
        addis           r2,r0,IVOR12_handler@ha
        addi            r2,r11,IVOR12_handler@l
	mtivor12	r2
        addis           r2,r0,IVOR13_handler@ha
        addi            r2,r11,IVOR13_handler@l
	mtivor13	r2
        addis           r2,r0,IVOR14_handler@ha
        addi            r2,r11,IVOR14_handler@l
	mtivor14	r2
        addis           r2,r0,IVOR15_handler@ha
        addi            r2,r11,IVOR15_handler@l
	mtivor15	r2
        addis           r2,r0,IVOR32_handler@ha
        addi            r2,r11,IVOR32_handler@l
	mtivor32	r2
        addis           r2,r0,IVOR33_handler@ha
        addi            r2,r11,IVOR33_handler@l
	mtivor33	r2
        addis           r2,r0,IVOR34_handler@ha
        addi            r2,r11,IVOR34_handler@l
	mtivor34	r2

_mmu_init:
	addis		r11,r0,_tlbdata@ha
	addi		r4,r11,_tlbdata@l
	lwz             r3, 0(r4)
	mtspr		624,r3
	lwzu            r3, 4(r4)
	mtspr		625,r3
	lwzu            r3, 4(r4)
	mtspr		626,r3
	lwzu            r3, 4(r4)
	mtspr		627,r3
	.long           0x7C0007A4 #tlbwr
	isync

	lwzu            r3, 4(r4)
	mtspr		624,r3
	lwzu            r3, 4(r4)
	mtspr		625,r3
	lwzu            r3, 4(r4)
	mtspr		626,r3
	lwzu            r3, 4(r4)
	mtspr		627,r3
	.long           0x7C0007A4 #tlbwr
	isync
	
_init_L2RAM:
	lis 		r3,0x4000 		# base address of the L2SRAM, 64-bit word aligned
	ori 		r3,r3,0 		# not needed for this address but could be forothers
	li 		r4,2048 		# loop counter to get all of L2SRAM;
						# 256k/4 bytes/32 GPRs = 2048
	mtctr 		r4
init_l2ram_loop:
	stmw 		r0,0(r3) 		# write all 32 GPRs to L2SRAM
	addi 		r3,r3,128 		# inc the ram ptr; 32 GPRs * 4 bytes = 128
	bdnz 		init_l2ram_loop 	# loop for 64k of L2SRAM
	
_init:
        addis           r11,r0,__SP_INIT@ha     # Initialize stack pointer r1 to
        addi            r1,r11,__SP_INIT@l      # value in linker command file.
        addis           r13,r0,_SDA_BASE_@ha    # Initialize r13 to sdata base
        addi            r13,r13,_SDA_BASE_@l    # (provided by linker).
        addis           r2,r0,_SDA2_BASE_@ha    # Initialize r2 to sdata2 base
        addi            r2,r2,_SDA2_BASE_@l     # (provided by linker).
        addi            r0,r0,0                 # Clear r0.
        stwu            r0,-64(r1)              # Terminate stack.

        bl              __init_main     	# Finishes initialization (copies .data
                                        	# ROM to RAM, clears .bss), then calls
                                        	# example main(), which calls exit(),
                                        	# which halts.

	b		exit			# never returns
	bl		main			# dummy to pull in main()



l1csr0_write:
	ori		r3,r3,2			# invalidate cache
	msync
	isync
	mtl1csr0	r3
_l1csr0_wait:
	mfl1csr0	r3
	andi.		r3,r3,2
	bgt		_l1csr0_wait
	blr

l1csr1_write:
	ori		r3,r3,2			# invalidate cache
	msync
	isync
	mtl1csr1	r3
_l1csr1_wait:
	mfl1csr1	r3
	andi.		r3,r3,2
	bgt		_l1csr1_wait
	blr

bucsr_write:
	msync
	isync
	mtbucsr		r3
	msync
	isync
	blr

	.text
GetProcessorID:
	mfspr           r3,286
	blr
	
	.org 0x00001000                 
IVOR0_handler:
	nop
	nop
	nop
	b IVOR0_handler
	
IVOR1_handler:
	nop
	nop
	nop
	b IVOR1_handler
	
IVOR2_handler:
	nop
	nop
	nop
	b IVOR2_handler
	
IVOR3_handler:
	nop
	nop
	nop
	b IVOR3_handler
	
IVOR4_handler:
	nop
	nop
	nop
	b IVOR4_handler
	
IVOR5_handler:
	nop
	nop
	nop
	b IVOR5_handler
	
IVOR6_handler:
	nop
	nop
	nop
	b IVOR6_handler
	
IVOR7_handler:
	nop
	nop
	nop
	b IVOR7_handler
	
IVOR8_handler:
	nop
	nop
	nop
	b IVOR8_handler
	
IVOR9_handler:
	nop
	nop
	nop
	b IVOR9_handler
	
IVOR10_handler:
	nop
	nop
	nop
	b IVOR10_handler
	
IVOR11_handler:
	nop
	nop
	nop
	b IVOR11_handler
	
IVOR12_handler:
	nop
	nop
	nop
	b IVOR12_handler
	
IVOR13_handler:
	nop
	nop
	nop
	b IVOR13_handler
	
IVOR14_handler:
	nop
	nop
	nop
	b IVOR14_handler
	
IVOR15_handler:
	nop
	nop
	nop
	b IVOR15_handler
	
IVOR32_handler:
	nop
	nop
	nop
	b IVOR32_handler
	
IVOR33_handler:
	nop
	nop
	nop
	b IVOR33_handler
	
IVOR34_handler:
	nop
	nop
	nop
	b IVOR34_handler
	