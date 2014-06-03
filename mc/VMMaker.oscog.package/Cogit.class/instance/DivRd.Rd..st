abstract instructions
DivRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: DivRdRd operand: dpreg1 operand: dpreg2