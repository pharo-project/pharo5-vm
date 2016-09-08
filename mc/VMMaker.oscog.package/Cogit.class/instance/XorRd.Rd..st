abstract instructions
XorRd: reg1 Rd: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: XorRdRd operand: reg1 operand: reg2