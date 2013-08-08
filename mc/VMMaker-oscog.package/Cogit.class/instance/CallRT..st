method map
CallRT: callTarget
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateCall: (self Call: callTarget)