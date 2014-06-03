primitives-access
primitiveNeedsFlush
	| failureCode needFlush |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	needFlush := self needsFlush.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1.
	interpreterProxy pushBool: needFlush.