compile abstract instructions
gen: opcode "<Integer>" quickConstant: operandOne "<Integer>" operand: operandTwo "<Integer|CogAbstractInstruction>" operand: operandThree "<Integer|CogAbstractInstruction>"
	"Quick constants are those the back end is free to encode as compactly as possible.""<Integer|CogAbstractInstruction>"
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkQuickConstant: operandOne
		forInstruction: (self gen: opcode operand: operandOne operand: operandTwo operand: operandThree)