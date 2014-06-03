accessing
getJmpTarget
	"Get the target of a jump instruction.  Jumps have the target in the first operand."
	^cogit cCoerceSimple: (operands at: 0) to: #'AbstractInstruction *'