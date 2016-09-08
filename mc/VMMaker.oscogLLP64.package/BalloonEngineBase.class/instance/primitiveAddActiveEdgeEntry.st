primitives-incremental
primitiveAddActiveEdgeEntry
	"Note: No need to load either bitBlt or spanBuffer"
	| failureCode edgeOop edge |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateWaitingForEdge) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	edgeOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	edge := self loadEdgeStateFrom: edgeOop.
	edge = nil ifTrue:[^interpreterProxy primitiveFailFor: GEFEdgeDataTooSmall].

	(self needAvailableSpace: 1) 
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWorkTooBig].

	(self edgeNumLinesOf: edge) > 0 ifTrue:[
		self insertEdgeIntoAET: edge.
	].

	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	self statePut: GEStateAddingFromGET. "Back to adding edges from GET"
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1. "Leave rcvr on stack"
	doProfileStats ifTrue:[
		self incrementStat: GWCountAddAETEntry by: 1.
		self incrementStat: GWTimeAddAETEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
