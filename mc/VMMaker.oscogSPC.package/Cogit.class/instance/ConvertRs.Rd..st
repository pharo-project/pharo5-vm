abstract instructions
ConvertRs: reg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: ConvertRsRd operand: reg1 operand: dpreg2