compile abstract instructions
gen: opcode "<Integer>" operand: operandOne "<Integer|CogAbstractInstruction>" quickConstant: operandTwo "<Integer>" operand: operandThree "<Integer|CogAbstractInstruction>"
	"Quick constants are those the back end is free to encode as compactly as possible.""<Integer|CogAbstractInstruction>"
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkQuickConstant: operandTwo
		forInstruction: (self gen: opcode operand: operandOne operand: operandTwo operand: operandThree)