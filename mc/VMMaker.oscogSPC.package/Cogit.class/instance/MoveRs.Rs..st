abstract instructions
MoveRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MoveRsRs operand: dpreg1 operand: dpreg2