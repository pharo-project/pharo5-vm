abstract instructions
ConvertR: reg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRRd operand: reg1 operand: dpreg2