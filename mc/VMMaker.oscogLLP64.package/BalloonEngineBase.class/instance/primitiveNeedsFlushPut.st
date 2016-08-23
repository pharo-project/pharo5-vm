primitives-access
primitiveNeedsFlushPut
	| failureCode needFlush |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	needFlush := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	needFlush == true 
		ifTrue:[self needsFlushPut: 1]
		ifFalse:[self needsFlushPut: 0].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"
