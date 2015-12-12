compile abstract instructions
genJumpNotSmallIntegersIn: aRegister andScratchReg: scratchReg
	"Generate a compare and branch to test if aRegister and scratchReg contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and scratchReg contain SmallIntegers.
	 Answer the jump.  Destroy scratchReg if required."
	<returnTypeC: #'AbstractInstruction *'>
	^cogit
		XorR: aRegister R: scratchReg;
		AndCq: objectMemory tagMask R: scratchReg;
		JumpNonZero: 0