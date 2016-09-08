compile abstract instructions
gen: opcode "<Integer>" operand: operandOne "<Integer|CogAbstractInstruction>" literal: operandTwo "<Integer>"
	"Literals are constants that either represent objects on the heap that may get updated by
	 the garbage collector, or pc-relative spans that may get changed by code compaction, and
	 must hence always be encoded in a form that allows updating to refer to a different value."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkLiteral: operandTwo
		forInstruction: (self gen: opcode operand: operandOne operand: operandTwo)