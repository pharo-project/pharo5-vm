generate machine code
machineCodeWords
	"Answer the maximum number of words of machine code generated for any abstract instruction.
	 e.g. CmpCwR =>
			lui at, <high>
			ori at, <low>
			subu Cmp, reg, at
			slt CmpSLT, reg, at
			slt CmpSGT, reg, at
			slt CmpULT, reg, at
			slt CmpUGT, reg, at"
	self flag: #inefficient.
	^7