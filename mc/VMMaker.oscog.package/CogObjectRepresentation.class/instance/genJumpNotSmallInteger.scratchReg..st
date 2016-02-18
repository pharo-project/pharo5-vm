compile abstract instructions
genJumpNotSmallInteger: aRegister scratchReg: scratch
	"Generate a compare and branch to test if aRegister contains other than a SmallInteger.
	 Answer the jump.  Use scratch if required.  Subclasses will override if scratch is needed."
	<inline: true>
	^self genJumpNotSmallInteger: aRegister