compile abstract instructions
genJumpSmallFloat: aRegister
	"Generate a compare and branch to test if aRegister contains a SmallFloat.
	 Answer the jump, or UnimplementedOperation if this cannot be done with
	 a single register."
	^cogit
		TstCq: objectMemory smallFloatTag R: aRegister;
		JumpNonZero: 0