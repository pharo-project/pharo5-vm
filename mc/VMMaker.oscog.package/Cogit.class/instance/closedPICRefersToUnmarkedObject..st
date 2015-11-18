garbage collection
closedPICRefersToUnmarkedObject: cPIC
	"Answer if the ClosedPIC refers to any unmarked objects or freed/freeable target methods,
	 applying markAndTraceOrFreeCogMethod:firstVisit: to those targets to determine if freed/freeable."
	<var: #cPIC type: #'CogMethod *'>
	| pc offsetToLiteral object entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	(objectMemory isImmediate: cPIC selector) ifFalse:
		[(objectMemory isMarked: cPIC selector) ifFalse:
			[^true]].
	"First jump is unconditional; subsequent ones are conditional."
	offsetToLiteral := backEnd jumpLongByteSize.
	1 to: cPIC cPICNumCases do:
		[:i| 
		pc := self addressOfEndOfCase: i inCPIC: cPIC.
		(objectRepresentation inlineCacheTagsMayBeObjects and: [i>1] ) "inline cache tags for the 0th case are at the send site" ifTrue:
			[object := literalsManager classRefInClosedPICAt: pc - offsetToLiteral.
			 ((objectRepresentation couldBeObject: object)
			  and: [(objectMemory isMarked: object) not]) ifTrue:
				[^true]].
		object := literalsManager objRefInClosedPICAt: pc - offsetToLiteral.
		((objectRepresentation couldBeObject: object)
		 and: [(objectMemory isMarked: object) not]) ifTrue:
			[^true].
		offsetToLiteral := backEnd jumpLongConditionalByteSize.
		entryPoint := i = 1
						ifTrue: [backEnd jumpLongTargetBeforeFollowingAddress: pc]
						ifFalse: [backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc].
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		self assert: (entryPoint > methodZoneBase and: [entryPoint < methodZone freeStart]).
		(cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: (targetMethod cmType = CMMethod
						or: [targetMethod cmType = CMFree]).
			 (self markAndTraceOrFreeCogMethod: targetMethod
				  firstVisit: targetMethod asUnsignedInteger > pc asUnsignedInteger) ifTrue:
				[^true]]].
	^false