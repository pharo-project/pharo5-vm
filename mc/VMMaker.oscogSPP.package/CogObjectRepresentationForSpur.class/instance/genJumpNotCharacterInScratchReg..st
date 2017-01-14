compile abstract instructions
genJumpNotCharacterInScratchReg: reg 
	cogit AndCq: objectMemory tagMask R: reg.
	cogit CmpCq: objectMemory characterTag R: reg.
	^cogit JumpNonZero: 0