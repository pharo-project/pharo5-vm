compile abstract instructions
genJumpSmallInteger: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains a SmallInteger.
	 Answer the jump.  Override since scratch is needed."
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		AndCq: objectMemory tagMask R: reg R: scratch;
		CmpCq: objectMemory smallIntegerTag R: scratch;
		JumpZero: 0