generate machine code
machineCodeBytes
	"Answer the maximum number of bytes of machine code generated for any abstract instruction.
	 e.g. movq $0x12345678ABCDEF0, %rax; jmp *%rax => 48 B8 F0 DE BC 9A 78 56 34 12 FF E0"
	^12