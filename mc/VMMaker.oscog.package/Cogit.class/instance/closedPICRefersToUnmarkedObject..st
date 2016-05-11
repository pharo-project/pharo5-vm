garbage collection
closedPICRefersToUnmarkedObject: cPIC
	"Answer if the ClosedPIC refers to any unmarked objects or freed/freeable target methods,
	 applying markAndTraceOrFreeCogMethod:firstVisit: to those targets to determine if freed/freeable."
	<var: #cPIC type: #'CogMethod *'>
	| pc object |
	((objectMemory isImmediate: cPIC selector)
	or: [objectMemory isMarked: cPIC selector]) ifFalse:
		[^true].

	"First jump is unconditional; subsequent ones are conditional."
	"Check the potential method oop for the first case only.
	 Inline cache tags for the 1st case are at the send site."
	pc := self addressOfEndOfCase: 1 inCPIC: cPIC.
	(objectRepresentation couldBeObject: (object := backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongByteSize)) ifTrue:
		[(objectMemory isMarked: object) ifFalse:
			[^true]].

	"Check the first target"
	(self markAndTraceOrFreePICTarget: (backEnd jumpLongTargetBeforeFollowingAddress: pc) in: cPIC) ifTrue:
		[^true].

	2 to: cPIC cPICNumCases do:
		[:i| 
		pc := self addressOfEndOfCase: i inCPIC: cPIC.
		(self inlineCacheTagsAreIndexes not
		 and: [objectRepresentation inlineCacheTagsMayBeObjects
		 and: [objectRepresentation couldBeObject: (object := backEnd literal32BeforeFollowingAddress: pc - backEnd jumpLongConditionalByteSize)]]) ifTrue:
			[(objectMemory isMarked: object) ifFalse:
				[^true]].
		"Check the potential method oop for subsequent cases."
		(objectRepresentation couldBeObject: (object := backEnd literalBeforeFollowingAddress: pc - backEnd jumpLongConditionalByteSize - backEnd cmpC32RTempByteSize)) ifTrue:
			[(objectMemory isMarked: object) ifFalse:
				[^true]].
		"Check subsequent targets"
		(self markAndTraceOrFreePICTarget: (backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc) in: cPIC) ifTrue:
			[^true]].

	^false