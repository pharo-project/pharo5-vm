compile abstract instructions
gen: opcode "<Integer>" literal: operandOne "<Integer>" operand: operandTwo "<Integer|CogAbstractInstruction>"
	"Literals are constants that either represent objects on the heap that may get updated by
	 the garbage collector, or pc-relative spans that may get changed by code compaction, and
	 must hence always be encoded in a form that allows updating to refer to a different value."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkLiteral: operandOne
		forInstruction: (self gen: opcode operand: operandOne operand: operandTwo)