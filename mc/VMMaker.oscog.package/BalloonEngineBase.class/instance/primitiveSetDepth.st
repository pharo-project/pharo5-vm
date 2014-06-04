primitives-access
primitiveSetDepth
	| failureCode depth |
	<export: true>
	<inline: false>

	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	depth := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self currentZPut: depth.

	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"