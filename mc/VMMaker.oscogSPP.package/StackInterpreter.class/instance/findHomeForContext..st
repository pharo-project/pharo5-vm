debug printing
findHomeForContext: aContext
	| closureOrNil |
	<inline: false>
	(objectMemory isContext: aContext) ifFalse:
		[^nil].
	closureOrNil := objectMemory fetchPointer: ClosureIndex ofObject: aContext.
	closureOrNil = objectMemory nilObject ifTrue:
		[^aContext].
	ClassBlockClosureCompactIndex ~= 0
		ifTrue:
			[((objectMemory compactClassIndexOf: closureOrNil) ~= ClassBlockClosureCompactIndex
			  and: [(objectMemory compactClassIndexOf: closureOrNil) ~= ClassFullBlockClosureCompactIndex]) ifTrue:
				[^nil]]
		ifFalse:
			[(objectMemory fetchClassOf: closureOrNil) ~= (objectMemory splObj: ClassBlockClosure) ifTrue:
				[(ClassFullBlockClosureCompactIndex ~= 0
				  and: [(objectMemory fetchClassOf: closureOrNil) = (objectMemory splObj: ClassFullBlockClosure)]) ifFalse:
					[^nil]]].
	^self findHomeForContext: (objectMemory fetchPointer: ClosureOuterContextIndex ofObject: closureOrNil)