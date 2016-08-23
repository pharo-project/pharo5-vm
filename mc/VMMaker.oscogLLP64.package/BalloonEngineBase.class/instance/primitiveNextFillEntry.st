primitives-incremental
primitiveNextFillEntry
	"Note: No need to load bitBlt but must load spanBuffer"
	| failureCode fillOop hasFill |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateScanningAET) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	"Load span buffer for internal handling of fills"
	(failureCode := self loadSpanBufferFrom:
		(interpreterProxy fetchPointer: BESpanIndex ofObject: engine)) = 0
			ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	(self loadFormsFrom:
		(interpreterProxy fetchPointer: BEFormsIndex ofObject: engine))
			ifFalse:[^interpreterProxy primitiveFailFor: GEFFormLoadFailed].

	"Check if we have to clear the span buffer before proceeding"
	(self clearSpanBufferGet = 0) ifFalse:[
		(self currentYGet bitAnd: self aaScanMaskGet) = 0
			ifTrue:[self clearSpanBuffer].
		self clearSpanBufferPut: 0].

	fillOop := interpreterProxy stackObjectValue: 0.
	hasFill := self findNextExternalFillFromAET.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].
	hasFill ifTrue:[self storeFillStateInto: fillOop].
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFWrongFill].
	hasFill
		ifTrue:[	self statePut: GEStateWaitingForFill]
		ifFalse:[	self wbStackClear.
				self spanEndAAPut: 0.
				self statePut: GEStateBlitBuffer].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 2.
	interpreterProxy pushBool: hasFill not.
	doProfileStats ifTrue:[
		self incrementStat: GWCountNextFillEntry by: 1.
		self incrementStat: GWTimeNextFillEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)]