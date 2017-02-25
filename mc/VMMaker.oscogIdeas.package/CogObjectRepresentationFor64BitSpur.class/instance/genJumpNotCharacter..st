compile abstract instructions
genJumpNotCharacter: reg
	"Generate a compare and branch to test if aRegister contains other than a Character."
	^cogit
		TstCq: objectMemory characterTag R: reg;
		JumpZero: 0