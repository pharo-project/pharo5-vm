abstract instructions
ConvertR: reg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRRs operand: reg1 operand: dpreg2