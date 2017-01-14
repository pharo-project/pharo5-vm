primitives-incremental
primitiveInitializeProcessing
	"Note: No need to load bitBlt but must load spanBuffer"
	<export: true>
	<inline: false>
	| failureCode |
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	"Load span buffer for clear operation"
	(failureCode := self loadSpanBufferFrom:
		(interpreterProxy fetchPointer: BESpanIndex ofObject: engine)) = 0
			ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	self initializeGETProcessing.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].
	self statePut: GEStateAddingFromGET. "Initialized"
	interpreterProxy failed ifFalse:[self storeEngineStateInto: engine].
	doProfileStats ifTrue:[
		self incrementStat: GWCountInitializing by: 1.
		self incrementStat: GWTimeInitializing by: (interpreterProxy ioMicroMSecs - geProfileTime)].
