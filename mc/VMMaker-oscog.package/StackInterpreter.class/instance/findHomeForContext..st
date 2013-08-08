debug printing
findHomeForContext: aContext
	| closureOrNil |
	<inline: false>
	(objectMemory isContext: aContext) ifFalse:
		[^nil].
	closureOrNil := objectMemory fetchPointer: ClosureIndex ofObject: aContext.
	closureOrNil = objectMemory nilObject ifTrue:
		[^aContext].
	(objectMemory fetchClassOf: closureOrNil) ~= (objectMemory splObj: ClassBlockClosure) ifTrue:
		[^nil].
	^self findHomeForContext: (objectMemory fetchPointer: ClosureOuterContextIndex ofObject: closureOrNil)