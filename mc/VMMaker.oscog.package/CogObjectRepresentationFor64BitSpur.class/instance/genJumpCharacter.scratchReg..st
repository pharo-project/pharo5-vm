compile abstract instructions
genJumpCharacter: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains a Character.
	 Answer the jump.  Override since scratch is needed."
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		AndCq: objectMemory tagMask R: reg R: scratch;
		CmpCq: objectMemory characterTag R: scratch;
		JumpZero: 0