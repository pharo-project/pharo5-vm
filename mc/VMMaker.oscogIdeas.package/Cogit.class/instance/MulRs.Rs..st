abstract instructions
MulRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MulRsRs operand: dpreg1 operand: dpreg2