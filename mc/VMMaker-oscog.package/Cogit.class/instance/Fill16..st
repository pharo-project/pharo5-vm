abstract instructions
Fill16: value
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	self assert: (value between: 0 and: 16rFFFF).
	^self gen: Fill16 operand: value