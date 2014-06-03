compile abstract instructions
jumpNotCharacterUnsignedValueInRegister: reg
	cogit CmpCq: 16r3FFFFFFF R: reg.
	^cogit JumpAbove: 0