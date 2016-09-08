abstract instructions
SubRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubRsRs operand: dpreg1 operand: dpreg2