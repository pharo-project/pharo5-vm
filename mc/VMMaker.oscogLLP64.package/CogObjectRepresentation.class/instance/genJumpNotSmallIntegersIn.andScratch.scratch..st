compile abstract instructions
genJumpNotSmallIntegersIn: aRegister andScratch: scratchA scratch: scratchB
	"Generate a compare and branch to test if aRegister and scratchA contains other than SmallIntegers,
	 i.e. don't branch if both aRegister and scratchA contain SmallIntegers.
	 Answer the jump.  Destroy scratchA and scratchB if required."
	<returnTypeC: #'AbstractInstruction *'>
	^self subclassResponsibility