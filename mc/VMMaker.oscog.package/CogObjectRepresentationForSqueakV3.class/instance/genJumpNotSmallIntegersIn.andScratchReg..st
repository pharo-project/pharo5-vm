compile abstract instructions
genJumpNotSmallIntegersIn: aRegister andScratchReg: scratchReg
	"Generate a compare and branch to test if aRegister and scratchReg contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and scratchReg contain SmallIntegers.
	 Answer the jump.  Destroy scratchReg if required."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	cogit AndR: aRegister R: scratchReg.
	^self genJumpNotSmallIntegerInScratchReg: scratchReg