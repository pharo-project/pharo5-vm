testing
byteReadsZeroExtend
	"Answer if a byte read, via MoveAbR, MoveMbrR, or MoveXbrRR zero-extends
	 into the full register, or merely affects the least significant 8 bits of the
	 the register.  By default the code generator assumes that byte reads
	 to not zero extend.  Note that byte reads /must not/ sign extend.
	 On x86 we always use movzbl"
	^true