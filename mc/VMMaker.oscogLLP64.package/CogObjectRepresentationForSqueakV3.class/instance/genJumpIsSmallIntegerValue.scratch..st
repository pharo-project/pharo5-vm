compile abstract instructions
genJumpIsSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value in the SmallInteger range, and a jump if so, answering the jump.
	 c.f. ObjectMemory>>isIntegerValue:"
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		MoveR: aRegister R: scratchReg;
		LogicalShiftLeftCq: 1 R: scratchReg;
		XorR: aRegister R: scratchReg;
		JumpGreaterOrEqual: 0