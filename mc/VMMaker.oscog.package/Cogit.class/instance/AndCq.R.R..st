abstract instructions
AndCq: quickConstant R: srcReg R: destReg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	| first |
	<var: 'first' type: #'AbstractInstruction *'>
	backEnd hasThreeAddressArithmetic ifTrue:
		[^self gen: AndCqRR operand: quickConstant operand: srcReg operand: destReg].
	first := self gen: MoveRR operand: srcReg operand: destReg.
	self gen: AndCqR operand: quickConstant operand: destReg.
	^first