method map
CallNewspeakSend: callTarget
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateNewspeakSend: (self Call: callTarget)