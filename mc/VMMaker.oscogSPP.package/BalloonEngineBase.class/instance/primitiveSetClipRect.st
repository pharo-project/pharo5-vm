primitives-access
primitiveSetClipRect
	| failureCode rectOop |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	rectOop := interpreterProxy stackObjectValue: 0.
	(interpreterProxy failed not
	and: [(interpreterProxy isPointers: rectOop)
	and: [(interpreterProxy slotSizeOf: rectOop) >= 2]])
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self loadPoint: self point1Get from: (interpreterProxy fetchPointer: 0 ofObject: rectOop).
	self loadPoint: self point2Get from: (interpreterProxy fetchPointer: 1 ofObject: rectOop).
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self clipMinXPut: (self point1Get at: 0).
	self clipMinYPut: (self point1Get at: 1).
	self clipMaxXPut: (self point2Get at: 0).
	self clipMaxYPut: (self point2Get at: 1).
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"