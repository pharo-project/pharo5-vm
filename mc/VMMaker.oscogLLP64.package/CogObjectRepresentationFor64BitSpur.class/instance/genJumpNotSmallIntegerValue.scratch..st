compile abstract instructions
genJumpNotSmallIntegerValue: aRegister scratch: scratchReg
	"Generate a test for aRegister containing an integer value outside the SmallInteger range, and a jump if so, answering the jump.
	 c.f. Spur64BitMemoryManager>>isIntegerValue:"
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		MoveR: aRegister R: scratchReg;
		ArithmeticShiftRightCq: 64 - objectMemory numTagBits R: scratchReg;
		AddCq: 1 R: scratchReg;
		AndCq: 1 << (objectMemory numTagBits + 1) - 1 R: scratchReg; "sign and top numTags bits must be the same"
		CmpCq: 1 R: scratchReg;
		JumpGreater: 0