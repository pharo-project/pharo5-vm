abstract instructions
XorRs: reg1 Rs: reg2
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: XorRsRs operand: reg1 operand: reg2