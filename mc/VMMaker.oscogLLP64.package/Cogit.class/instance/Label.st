abstract instructions
Label
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: Label operand: (labelCounter := labelCounter + 1) operand: bytecodePC