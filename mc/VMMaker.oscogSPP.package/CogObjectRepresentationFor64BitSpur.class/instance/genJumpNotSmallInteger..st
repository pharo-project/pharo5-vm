compile abstract instructions
genJumpNotSmallInteger: reg
	"Generate a compare and branch to test if aRegister contains other than a SmallInteger."
	^cogit
		TstCq: objectMemory smallIntegerTag R: reg;
		JumpZero: 0