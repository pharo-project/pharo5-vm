primitives-incremental
primitiveMergeFillFrom
	"Note: No need to load bitBlt but must load spanBuffer"
	| failureCode fillOop bitsOop value |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 2)
						requiredState: GEStateWaitingForFill) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	"Load span buffer for merging the fill"
	(failureCode := self loadSpanBufferFrom:
		(interpreterProxy fetchPointer: BESpanIndex ofObject: engine)) = 0
			ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	fillOop := interpreterProxy stackObjectValue: 0.
	bitsOop := interpreterProxy stackObjectValue: 1.
	"Check bitmap"
	(interpreterProxy failed not
	and: [(interpreterProxy fetchClassOf: bitsOop) = interpreterProxy classBitmap])
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	"Check fillOop"
	(interpreterProxy slotSizeOf: fillOop) < FTBalloonFillDataSize
		ifTrue:[^interpreterProxy primitiveFailFor: GEFFillDataTooSmall].
	"Check if this was the fill we have exported"
	value := interpreterProxy fetchInteger: FTIndexIndex ofObject: fillOop.
	(self objectIndexOf: self lastExportedFillGet) = value
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].
	value := interpreterProxy fetchInteger: FTMinXIndex ofObject: fillOop.
	self lastExportedLeftXGet = value
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].
	value := interpreterProxy fetchInteger: FTMaxXIndex ofObject: fillOop.
	self lastExportedRightXGet = value
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].

	(interpreterProxy slotSizeOf: bitsOop) < (self lastExportedRightXGet - self lastExportedLeftXGet)
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	interpreterProxy failed ifTrue:[^nil].

	self fillBitmapSpan: (interpreterProxy firstIndexableField: bitsOop)
		from: self lastExportedLeftXGet
		to: self lastExportedRightXGet.

	self statePut: GEStateScanningAET. "Back to scanning AET"
	self storeEngineStateInto: engine.
	interpreterProxy pop: 2. "Leave rcvr on stack"
	doProfileStats ifTrue:[
		self incrementStat: GWCountMergeFill by: 1.
		self incrementStat: GWTimeMergeFill by: (interpreterProxy ioMicroMSecs - geProfileTime)].
