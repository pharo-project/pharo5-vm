method introspection
populate: tuple withPICInfoFor: cPIC firstCacheTag: firstCacheTag
	"Populate tuple (which must be large enough) with the ClosedPIC's target method class pairs.
	 The first entry in tuple contains the bytecode pc for the send, so skip the tuple's first field."
	<var: #cPIC type: #'CogMethod *'>
	| pc cacheTag classOop entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	self halt.
	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		cacheTag := i = 1
						ifTrue: [firstCacheTag]
						ifFalse: [backEnd literalBeforeFollowingAddress: pc
																		- backEnd jumpLongConditionalByteSize
																		- backEnd loadLiteralByteSize].
		classOop := objectRepresentation classForInlineCacheTag: cacheTag.
		objectMemory storePointer: i * 2 - 1 ofObject: tuple withValue: classOop.
		entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(entryPoint asUnsignedInteger < cPIC asUnsignedInteger
		 or: [entryPoint asUnsignedInteger > (cPIC asUnsignedInteger + cPIC blockSize) asUnsignedInteger])
			ifTrue:
				[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
				 self assert: targetMethod cmType = CMMethod.
				 objectMemory storePointer: i * 2 ofObject: tuple withValue: targetMethod methodObject].
		pc := pc + cPICCaseSize]