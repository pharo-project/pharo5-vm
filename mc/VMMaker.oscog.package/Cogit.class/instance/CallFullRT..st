method map
CallFullRT: callTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateCall: (self CallFull: callTarget)