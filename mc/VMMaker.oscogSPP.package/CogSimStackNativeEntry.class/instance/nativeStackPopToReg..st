compile abstract instructions
nativeStackPopToReg: reg
	self assert: spilled.

		type caseOf: {
			[SSSpillNative]	-> [cogit MoveMw: offset negated r: FPReg R: reg].
			[SSSpillFloat32]	-> [cogit MoveM32: offset negated r: FPReg Rs: reg.].
			[SSSpillFloat64]	-> [cogit MoveM64: offset negated r: FPReg Rd: reg.].
	}