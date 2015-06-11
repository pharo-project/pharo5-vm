method map
annotateNewspeakSend: abstractInstruction
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	abstractInstruction annotation: IsNSSendCall.
	^abstractInstruction