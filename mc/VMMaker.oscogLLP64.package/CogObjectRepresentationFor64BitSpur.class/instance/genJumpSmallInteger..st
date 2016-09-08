compile abstract instructions
genJumpSmallInteger: aRegister
	"Generate a compare and branch to test if aRegister contains a SmallInteger.
	 Answer the jump, or UnimplementedOperation if this cannot be done with
	 a single register."
	^cogit
		TstCq: objectMemory smallIntegerTag R: aRegister;
		JumpNonZero: 0