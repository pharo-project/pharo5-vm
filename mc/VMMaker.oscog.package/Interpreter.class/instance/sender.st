contexts
sender

	| context closureOrNil |
	context := localHomeContext.
	[(closureOrNil := self fetchPointer: ClosureIndex ofObject: context) ~~ nilObj] whileTrue:
		[context := self fetchPointer: ClosureOuterContextIndex ofObject: closureOrNil].
	^self fetchPointer: SenderIndex ofObject: context