generate machine code
machineCodeBytes
	"Answer the maximum number of bytes of machine code generated for any abstract instruction.
	 e.g. lock movsd  0x400(%esp),%xmm4 => f0 f2 0f 10 a4 24 00 04 00 00"
	^10