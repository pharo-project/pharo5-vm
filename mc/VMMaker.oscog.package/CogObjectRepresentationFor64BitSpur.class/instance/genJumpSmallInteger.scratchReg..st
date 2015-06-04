compile abstract instructions
genJumpSmallInteger: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains a SmallInteger.
	 Answer the jump.  Override since scratch is needed."
	cogit AndCq: objectMemory tagMask R: reg R: scratch.
	cogit CmpCq: objectMemory smallIntegerTag R: scratch.
	^cogit JumpZero: 0