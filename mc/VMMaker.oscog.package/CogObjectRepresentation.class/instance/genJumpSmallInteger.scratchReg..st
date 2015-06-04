compile abstract instructions
genJumpSmallInteger: aRegister scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains a SmallInteger.
	 Answer the jump.  Use scratch if required.  Subclasses will override if scratch is needed."
	<returnTypeC: #'AbstractInstruction *'>
	^self genJumpSmallInteger: aRegister