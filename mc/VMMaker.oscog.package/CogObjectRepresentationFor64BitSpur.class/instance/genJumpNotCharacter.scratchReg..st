compile abstract instructions
genJumpNotCharacter: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains other than a Character.
	 Answer the jump.  Override since scratch is needed."
	^cogit
		AndCq: objectMemory tagMask R: reg R: scratch;
		CmpCq: objectMemory characterTag R: scratch;
		JumpNonZero: 0