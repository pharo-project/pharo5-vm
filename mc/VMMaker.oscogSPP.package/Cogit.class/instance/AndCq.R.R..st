abstract instructions
AndCq: quickConstant R: srcReg R: destReg
	<inline: false>
	<returnTypeC: #'AbstractInstruction *'>
	| first |
	<var: 'first' type: #'AbstractInstruction *'>
	backEnd hasThreeAddressArithmetic ifTrue:
		[^self gen: AndCqRR quickConstant: quickConstant operand: srcReg operand: destReg].
	srcReg = destReg ifTrue:
		[^self gen: AndCqR quickConstant: quickConstant operand: destReg.].
	first := self gen: MoveRR operand: srcReg operand: destReg.
	self gen: AndCqR quickConstant: quickConstant operand: destReg.
	^first