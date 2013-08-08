method map
CallSend: callTarget
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateSend: (self Call: callTarget)