generate machine code
machineCodeBytes
	"Answer the maximum number of bytes of machine code generated for any abstract instruction.
	 e.g. xchg %rdx, %rax; movq $0x12345678ABCDEF0, %(rax); xchg %rdx, %rax => 48 92 48 A3 F0 DE BC 9A 78 56 34 12 48 92"
	^14