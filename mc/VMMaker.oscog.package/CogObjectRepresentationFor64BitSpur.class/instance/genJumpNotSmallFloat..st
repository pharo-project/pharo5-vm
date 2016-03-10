compile abstract instructions
genJumpNotSmallFloat: reg
	"Generate a compare and branch to test if aRegister contains other than a SmallFloat.
	 Answer the jump."
	^cogit
		TstCq: objectMemory smallFloatTag R: reg;
		JumpZero: 0