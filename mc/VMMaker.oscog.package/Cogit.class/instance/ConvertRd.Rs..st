abstract instructions
ConvertRd: reg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRdRs operand: reg1 operand: dpreg2