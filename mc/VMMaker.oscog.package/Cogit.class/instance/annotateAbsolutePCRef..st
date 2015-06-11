method map
annotateAbsolutePCRef: abstractInstruction
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	abstractInstruction annotation: IsAbsPCReference.
	^abstractInstruction