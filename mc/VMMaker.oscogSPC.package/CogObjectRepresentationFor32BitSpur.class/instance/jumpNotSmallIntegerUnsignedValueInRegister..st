primitive generators
jumpNotSmallIntegerUnsignedValueInRegister: reg
	cogit CmpCq: 16r3FFFFFFF R: reg.
	^cogit JumpAbove: 0