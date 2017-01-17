abstract instructions
AddRs: dpreg1 Rs: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddRsRs operand: dpreg1 operand: dpreg2