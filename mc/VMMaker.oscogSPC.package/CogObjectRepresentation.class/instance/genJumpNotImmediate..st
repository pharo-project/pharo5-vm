compile abstract instructions
genJumpNotImmediate: aRegister
	"Generate a compare and branch to test if aRegister contains a non-immediate.
	 Answer the jump."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility
	