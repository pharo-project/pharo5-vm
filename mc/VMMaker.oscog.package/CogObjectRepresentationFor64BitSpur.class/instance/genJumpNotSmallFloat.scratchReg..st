compile abstract instructions
genJumpNotSmallFloat: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains other than a SmallFloat.
	 Answer the jump."
	cogit AndCq: objectMemory tagMask R: reg R: scratch.
	cogit CmpCq: objectMemory smallFloatTag R: scratch.
	^cogit JumpNonZero: 0