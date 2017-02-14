accessing
getJmpTarget
	"Get the target of a jump instruction.  Jumps have the target in the first operand."
	<inline: true>
	^cogit cCoerceSimple: (operands at: 0) to: #'AbstractInstruction *'