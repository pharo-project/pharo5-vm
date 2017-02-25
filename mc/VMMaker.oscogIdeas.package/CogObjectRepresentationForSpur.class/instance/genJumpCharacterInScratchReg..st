compile abstract instructions
genJumpCharacterInScratchReg: reg 
	cogit AndCq: objectMemory tagMask R: reg.
	cogit CmpCq: objectMemory characterTag R: reg.
	^cogit JumpZero: 0