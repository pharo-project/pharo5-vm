abstract instructions
CmpRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpRsRs operand: dpreg1 operand: dpreg2