compile abstract instructions
genJumpNotSmallIntegersIn: aRegister andScratch: scratchA scratch: scratchB
	"Generate a compare and branch to test if aRegister and scratchA contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and scratchA contain SmallIntegers.
	 Answer the jump.  Destroy scratchA and scratchB if required."
	<returnTypeC: #'AbstractInstruction *'>
	"Map SmallIntegers to 0 in scratchA & scratchB, add and jump non-zero."
	^cogit
		MoveR: aRegister R: scratchB;
		SubCq: objectMemory smallIntegerTag R: scratchA;
		SubCq: objectMemory smallIntegerTag R: scratchB;
		AndCq: objectMemory tagMask R: scratchA;
		AndCq: objectMemory tagMask R: scratchB;
		AddR: scratchA R: scratchB;
		JumpNonZero: 0