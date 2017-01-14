abstract instructions
MulRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: MulRdRd operand: dpreg1 operand: dpreg2