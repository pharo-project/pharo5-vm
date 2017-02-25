compile abstract instructions
genJumpNotSmallIntegersIn: aRegister and: bRegister scratch: scratchRegister
	"Generate a compare and branch to test if aRegister and bRegister contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and bRegister contain SmallIntegers.
	 Answer the jump.  Destroy scratchRegister if required."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	cogit
		MoveR: aRegister R: scratchRegister;
		AndR: bRegister R: scratchRegister.
	^self genJumpNotSmallIntegerInScratchReg: scratchRegister