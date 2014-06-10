debug printing
findHomeForContext: aContext
	| closureOrNil |
	<inline: false>
	(self isMethodContext: aContext) ifFalse:
		[^self fetchPointer: HomeIndex ofObject: aContext].
	closureOrNil := self fetchPointer: ClosureIndex ofObject: aContext.
	closureOrNil = self nilObject ifTrue:
		[^aContext].
	^self findHomeForContext: (self fetchPointer: ClosureOuterContextIndex ofObject: closureOrNil)