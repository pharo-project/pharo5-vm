compile abstract instructions
gen: opcode "<Integer>" operand: operandOne "<Integer|CogAbstractInstruction>" quickConstant: operandTwo "Integer>"
	"Quick constants are those the back end is free to encode as compactly as possible."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkQuickConstant: operandTwo
		forInstruction: (self gen: opcode operand: operandOne operand: operandTwo)