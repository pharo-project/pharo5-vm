primitives-other
primitiveAbortProcessing
	<export: true>
	<inline: false>
	| failureCode |
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	self statePut: GEStateCompleted.
	self storeEngineStateInto: engine.