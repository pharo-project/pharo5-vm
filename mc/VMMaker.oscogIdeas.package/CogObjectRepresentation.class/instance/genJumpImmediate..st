compile abstract instructions
genJumpImmediate: aRegister
	"Generate a compare and branch to test if aRegister contains an immediate.
	 Answer the jump."
	<returnTypeC: #'AbstractInstruction *'>
	self subclassResponsibility
	