testing
prevInstIsPCAnnotated
	| prevIndex prevInst |
	<var: #prevInst type: #'AbstractInstruction *'>
	opcodeIndex > 0 ifFalse:
		[^false].
	prevIndex := opcodeIndex - 1.
	[prevIndex <= 0 ifTrue: [^false].
	 prevInst := self abstractInstructionAt: prevIndex.
	 (self isPCMappedAnnotation: (prevInst annotation ifNil: [0])) ifTrue:
		[^true].
	 prevInst opcode = Label]
		whileTrue:
			[prevIndex := prevIndex - 1].
	^false