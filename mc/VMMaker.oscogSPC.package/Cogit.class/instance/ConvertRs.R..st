abstract instructions
ConvertRs: reg1 R: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRsR operand: reg1 operand: dpreg2