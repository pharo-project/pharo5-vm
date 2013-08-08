testing
prevInstIsPCAnnotated
	| annotation prevIndex prevInst |
	<var: #annotation type: #'InstructionAnnotation *'>
	<var: #prevInst type: #'AbstractInstruction *'>
	annotationIndex > 0 ifFalse:
		[^false].
	annotation := self addressOf: (annotations at: annotationIndex - 1).
	(self isPCMappedAnnotation: annotation annotation
			alternateInstructionSet: bytecodeSetOffset > 0) ifFalse:
		[^false].
	prevIndex := opcodeIndex - 1.
	[prevIndex <= 0 ifTrue: [^false].
	 prevInst := self abstractInstructionAt: prevIndex.
	 annotation instruction = prevInst ifTrue:
		[^true].
	 prevInst opcode = Label]
		whileTrue:
			[prevIndex := prevIndex - 1].
	^false