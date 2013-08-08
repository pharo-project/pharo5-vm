accessing
jmpTarget: anAbstractInstruction
	"Set the target of a jump instruction.  These all have the target in the first operand."
	<returnTypeC: #'AbstractInstruction *'>
	<var: #anAbstractInstruction type: #'AbstractInstruction *'>
	operands at: 0 put: anAbstractInstruction asUnsignedInteger.
	^anAbstractInstruction