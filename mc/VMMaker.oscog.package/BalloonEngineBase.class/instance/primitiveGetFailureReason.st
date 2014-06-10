primitives-access
primitiveGetFailureReason
	"Return the reason why the last operation failed."
	<export: true>
	<inline: false>
	| failCode |
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	engine := interpreterProxy stackValue: 0.
	"Note -- don't call loadEngineFrom here because this will override the stopReason with Zero"
	(interpreterProxy isImmediate: engine) ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineIsInteger].
	(interpreterProxy isPointers: engine) ifFalse:[^interpreterProxy primitiveFailFor: GEFEngineIsWords].
	(interpreterProxy slotSizeOf: engine) < BEBalloonEngineSize ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineTooSmall].
	(failCode := self loadWorkBufferFrom: 
		(interpreterProxy fetchPointer: BEWorkBufferIndex ofObject: engine)) = 0
			ifFalse:[^interpreterProxy primitiveFailFor: failCode].
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self stopReasonGet.