compile abstract instructions
nativeStackPopToReg: reg secondReg: secondReg
	self assert: spilled.

		type caseOf: {
			[SSSpillInt64]	-> [cogit MoveMw: offset negated + 4 r: FPReg R: reg.
							     cogit MoveMw: offset negated r: FPReg R: secondReg].
	}