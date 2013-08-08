abstract instructions
MoveRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRdRd operand: dpreg1 operand: dpreg2