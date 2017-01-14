abstract instructions
DivRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: DivRsRs operand: dpreg1 operand: dpreg2