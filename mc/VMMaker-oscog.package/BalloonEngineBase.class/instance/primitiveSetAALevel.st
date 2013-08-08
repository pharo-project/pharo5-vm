primitives-access
primitiveSetAALevel
	| failureCode level |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	level := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self setAALevel: level.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"