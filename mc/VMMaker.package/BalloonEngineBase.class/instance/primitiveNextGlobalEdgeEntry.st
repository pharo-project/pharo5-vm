primitives-incremental
primitiveNextGlobalEdgeEntry
	"Note: No need to load either bitBlt or spanBuffer"
	| failureCode edgeOop hasEdge edge |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateAddingFromGET) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	edgeOop := interpreterProxy stackObjectValue: 0.
	hasEdge := self findNextExternalEntryFromGET.
	hasEdge ifTrue:[
		edge := getBuffer at: self getStartGet.
		self storeEdgeStateFrom: edge into: edgeOop.
		self getStartPut: self getStartGet + 1].

	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFWrongEdge].

	hasEdge
		ifTrue:[	self statePut: GEStateWaitingForEdge] "Wait for adding edges"
		ifFalse:[ "Start scanning the AET"
				self statePut: GEStateScanningAET.
				self clearSpanBufferPut: 1. "Clear span buffer at next entry"
				self aetStartPut: 0.
				self wbStackClear].
	self storeEngineStateInto: engine.

	interpreterProxy pop: 2.
	interpreterProxy pushBool: hasEdge not.
	doProfileStats ifTrue:[
		self incrementStat: GWCountNextGETEntry by: 1.
		self incrementStat: GWTimeNextGETEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
