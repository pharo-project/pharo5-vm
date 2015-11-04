compile abstract instructions
genJumpSmallFloat: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains a SmallFloat.
	 Answer the jump.  Override since scratch is needed."
	cogit AndCq: objectMemory tagMask R: reg R: scratch.
	cogit CmpCq: objectMemory smallFloatTag R: scratch.
	^cogit JumpZero: 0