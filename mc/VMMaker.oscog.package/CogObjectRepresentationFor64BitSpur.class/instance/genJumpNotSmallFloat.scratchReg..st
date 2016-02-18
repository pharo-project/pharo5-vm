compile abstract instructions
genJumpNotSmallFloat: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains other than a SmallFloat.
	 Answer the jump."
	^cogit
		AndCq: objectMemory tagMask R: reg R: scratch;
		CmpCq: objectMemory smallFloatTag R: scratch;
		JumpNonZero: 0