encoding
concreteDPFPRegister: registerIndex
	 "Map a possibly abstract double-precision floating-point register into a concrete one.
	  Abstract registers (defined in CogAbstractOpcodes) are all negative.  If registerIndex
	  is negative assume it is an abstract register."

	^registerIndex
		caseOf: {
			[DPFPReg0]	-> [D0].
			[DPFPReg1]	-> [D1].
			[DPFPReg2]	-> [D2].
			[DPFPReg3]	-> [D3].
			[DPFPReg4]	-> [D4].
			[DPFPReg5]	-> [D5].
			[DPFPReg6]	-> [D6].
			[DPFPReg7]	-> [D7] }
		otherwise:
			[self assert: (registerIndex between: D0 and: D7).
			 registerIndex]