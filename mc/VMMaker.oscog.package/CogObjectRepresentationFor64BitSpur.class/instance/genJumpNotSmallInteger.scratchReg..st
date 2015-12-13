compile abstract instructions
genJumpNotSmallInteger: reg scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains other than a SmallInteger.
	 Answer the jump.  Override since scratch is needed."
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		AndCq: objectMemory tagMask R: reg R: scratch;
		CmpCq: objectMemory smallIntegerTag R: scratch;
		JumpNonZero: 0