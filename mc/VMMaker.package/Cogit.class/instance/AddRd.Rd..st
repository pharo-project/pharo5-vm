abstract instructions
AddRd: dpreg1 Rd: dpreg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: AddRdRd operand: dpreg1 operand: dpreg2