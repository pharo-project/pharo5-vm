compile abstract instructions
genJumpIsSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value in the SmallInteger range, and a jump if so, answering the jump.
	 c.f. Spur64BitMemoryManager>>isIntegerValue:"
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		MoveR: aRegister R: scratchReg;
		ArithmeticShiftRightCq: 64 - self numTagBits R: scratchReg;
		AddCq: 1 R: scratchReg;
		AndCq: 1 << (self numTagBits + 1) - 1 R: scratchReg; "sign and top numTags bits must be the same"
		CmpCq: 1 R: scratchReg;
		JumpGreaterOrEqual: 0