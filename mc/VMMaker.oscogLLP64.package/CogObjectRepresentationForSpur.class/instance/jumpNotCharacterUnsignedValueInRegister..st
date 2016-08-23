compile abstract instructions
jumpNotCharacterUnsignedValueInRegister: reg
	cogit CmpCq: 1 << self numCharacterBits - 1 R: reg.
	^cogit JumpAbove: 0