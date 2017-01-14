compile abstract instructions
gen: opcode "<Integer>" quickConstant: operand "<Integer>"
	"Quick constants are those the back end is free to encode as compactly as possible."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^literalsManager
		checkQuickConstant: operand
		forInstruction: (self gen: opcode operand: operand)