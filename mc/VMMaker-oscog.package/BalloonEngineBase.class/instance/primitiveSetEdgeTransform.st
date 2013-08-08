primitives-access
primitiveSetEdgeTransform
	| failureCode transformOop |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	transformOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self loadEdgeTransformFrom: transformOop.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"