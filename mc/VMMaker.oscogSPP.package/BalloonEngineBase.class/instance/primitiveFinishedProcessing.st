primitives-other
primitiveFinishedProcessing
	| finished failureCode |
	<export: true>
	<inline: false>
	doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
	interpreterProxy methodArgumentCount = 0
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 0)) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].
	finished := self finishedProcessing.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 1.
	interpreterProxy pushBool: finished.
	doProfileStats ifTrue:[
		self incrementStat: GWCountFinishTest by: 1.
		self incrementStat: GWTimeFinishTest by: (interpreterProxy ioMicroMSecs - geProfileTime)].
