compile abstract instructions
genJumpNotSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value outside the SmallInteger range, and a jump if so, answering the jump.
	 c.f. ObjectMemory>>isIntegerValue:"
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		MoveR: aRegister R: scratchReg;
		ArithmeticShiftRightCq: 1 R: scratchReg;
		XorR: aRegister R: scratchReg;
		JumpLess: 0