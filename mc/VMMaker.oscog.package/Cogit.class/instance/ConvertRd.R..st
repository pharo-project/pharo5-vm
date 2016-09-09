abstract instructions
ConvertRd: reg1 R: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRdR operand: reg1 operand: dpreg2