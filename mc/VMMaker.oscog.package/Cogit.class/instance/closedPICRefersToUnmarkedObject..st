garbage collection
closedPICRefersToUnmarkedObject: cPIC
	"Answer if the ClosedPIC refers to any unmarked objects or freed/freeable target methods,
	 applying markAndTraceOrFreeCogMethod:firstVisit: to those targets to determine if freed/freeable."
	<var: #cPIC type: #'CogMethod *'>
	| pc offsetToLiteral object entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	(objectMemory isMarked: cPIC selector)  ifFalse:
		[^true].
	pc := cPIC asInteger + firstCPICCaseOffset.
	"First jump is unconditional; subsequent ones are conditional"
	offsetToLiteral := backEnd jumpLongByteSize.
	1 to: cPIC cPICNumCases do:
		[:i|
		object := backEnd literalBeforeFollowingAddress: pc - offsetToLiteral - backEnd loadLiteralByteSize.
		((objectRepresentation couldBeObject: object)
		 and: [(objectMemory isMarked: object) not]) ifTrue:
			[^true].
		object := backEnd literalBeforeFollowingAddress: pc - offsetToLiteral.
		((objectRepresentation couldBeObject: object)
		 and: [(objectMemory isMarked: object) not]) ifTrue:
			[^true].
		entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(entryPoint asUnsignedInteger < cPIC asUnsignedInteger
		 or: [entryPoint asUnsignedInteger > (cPIC asUnsignedInteger + cPIC blockSize) asUnsignedInteger]) ifTrue:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: (targetMethod cmType = CMMethod
						or: [targetMethod cmType = CMFree]).
			 (self markAndTraceOrFreeCogMethod: targetMethod
				  firstVisit: targetMethod asUnsignedInteger > pc asUnsignedInteger) ifTrue:
				[^true]].
		offsetToLiteral := backEnd jumpLongConditionalByteSize.
		pc := pc + cPICCaseSize].
	^false