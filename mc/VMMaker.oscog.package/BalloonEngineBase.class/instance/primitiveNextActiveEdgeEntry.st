primitives-incremental
primitiveNextActiveEdgeEntry
	"Note: No need to load either bitBlt or spanBuffer"
	| failureCode edgeOop hasEdge edge |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUpdateEdges or: GEStateCompleted) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	edgeOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	hasEdge := false.
	self stateGet = GEStateCompleted ifFalse:[
		hasEdge := self findNextExternalUpdateFromAET.
		hasEdge ifTrue:[
			edge := aetBuffer at: self aetStartGet.
			self storeEdgeStateFrom: edge into: edgeOop.
			"Do not advance to the next aet entry yet"
			"self aetStartPut: self aetStartGet + 1."
			self statePut: GEStateWaitingChange. "Wait for changed edge"
		] ifFalse:[self statePut: GEStateAddingFromGET]. "Start over"
	].
	interpreterProxy failed ifTrue:[^nil].

	self storeEngineStateInto: engine.

	interpreterProxy pop: 2.
	interpreterProxy pushBool: hasEdge not.
	doProfileStats ifTrue:[
		self incrementStat: GWCountNextAETEntry by: 1.
		self incrementStat: GWTimeNextAETEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
