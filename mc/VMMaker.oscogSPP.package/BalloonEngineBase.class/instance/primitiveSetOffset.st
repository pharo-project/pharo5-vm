primitives-access
primitiveSetOffset
	| failureCode pointOop |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	pointOop := interpreterProxy stackValue: 0.
	(interpreterProxy fetchClassOf: pointOop) = interpreterProxy classPoint
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self loadPoint: self point1Get from: pointOop.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	self destOffsetXPut: (self point1Get at: 0).
	self destOffsetYPut: (self point1Get at: 1).
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"