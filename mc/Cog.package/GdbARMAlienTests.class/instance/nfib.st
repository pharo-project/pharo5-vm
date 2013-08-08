accessing
nfib
	"long fib(long n) { return n <= 1 ? 1 : fib(n-1) + fib(n-2) + 1; }
	 as compiled by arm-elf-gnuabi-gcc fib.c -c -marm
	also, the jumps are changed by hand."
	"| bat nfib ip |
	bat := GdbARMAlienTests new.
	nfib := bat nfib asWordArray.
	ip := 0.
	23 timesRepeat:
		[bat processor disassembleInstructionAt: ip In: nfib into:
			[:da :len|
			Transcript nextPutAll: da; cr; flush.
			ip := ip + len]]"
	^#("00000000 <fib>:
	   0:"		16re92d4810 		"push	{r4, fp, lr}	fp = r11, sp is changed in this command
	   4:"		16re28db008 		"add	fp, sp, #8	now, the frame pointer is changed
	   8:"		16re24dd00c 		"sub	sp, sp, #12
	   c:"		16re50b0010 		"str	r0, [fp, #-16]
	  10:"		16re51b3010 		"ldr	r3, [fp, #-16]	r3 <- [fp-16] <- r0
	  14:"		16re3530001 		"cmp	r3, #1
	  18:"		16rda00000c 		"ble	50 <fib+0x50>
	  1c:"		16re51b3010 		"ldr	r3, [fp, #-16]
	  20:"		16re2433001 		"sub	r3, r3, #1
	  24:"		16re1a00003 		"mov	r0, r3
	  28:"		16rebfffff4 		"bl	0 <fib>
	  2c:"		16re1a04000 		"mov	r4, r0
	  30:"		16re51b3010 		"ldr	r3, [fp, #-16]
	  34:"		16re2433002	 	"sub	r3, r3, #2
	  38:"		16re1a00003 		"mov	r0, r3
	  3c:"		16rebffffef 		"bl	0 <fib>
	  40:"		16re1a03000 		"mov	r3, r0
	  44:"		16re0843003 		"add	r3, r4, r3
	  48:"		16re2833001 		"add	r3, r3, #1
	  4c:"		16rea000000 		"b	54 <fib+0x54>
	  50:"		16re3a03001 		"mov	r3, #1
	  54:"		16re1a00003 		"mov	r0, r3
	  58:"		16re24bd008 		"sub	sp, fp, #8
	  5c:"		16re8bd8810 		"pop	{r4, fp, pc}")