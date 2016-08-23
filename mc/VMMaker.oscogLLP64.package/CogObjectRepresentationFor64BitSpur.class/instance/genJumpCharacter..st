compile abstract instructions
genJumpCharacter: reg
	"Generate a compare and branch to test if aRegister contains a Character."
	^cogit
		TstCq: objectMemory characterTag R: reg;
		JumpNonZero: 0