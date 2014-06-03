abstract instructions
CmpRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CmpRdRd operand: dpreg1 operand: dpreg2