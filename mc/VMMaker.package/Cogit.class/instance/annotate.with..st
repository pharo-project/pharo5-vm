method map
annotate: abstractInstruction with: annotationFlag "<Integer>"
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	| annotation |
	<var: #annotation type: #'InstructionAnnotation *'>
	annotation := self addressOf: (annotations at: annotationIndex).
	annotationIndex := annotationIndex + 1.
	annotation
		instruction: abstractInstruction;
		annotation: annotationFlag.
	^abstractInstruction