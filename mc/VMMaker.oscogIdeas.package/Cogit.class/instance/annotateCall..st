method map
annotateCall: abstractInstruction
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	abstractInstruction annotation: IsRelativeCall.
	^abstractInstruction