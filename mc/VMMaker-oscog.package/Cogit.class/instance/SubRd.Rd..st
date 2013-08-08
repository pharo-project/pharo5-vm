abstract instructions
SubRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: SubRdRd operand: dpreg1 operand: dpreg2