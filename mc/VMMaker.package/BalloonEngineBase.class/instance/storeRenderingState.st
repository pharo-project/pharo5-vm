primitives-rendering
storeRenderingState
	<inline: false>
	interpreterProxy failed ifTrue:[^nil].
	engineStopped ifTrue:[
		"Check the stop reason and store the required information"
		self storeStopStateIntoEdge: (interpreterProxy stackObjectValue: 1) 
			fill: (interpreterProxy stackObjectValue: 0).
	].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 3.
	interpreterProxy pushInteger: self stopReasonGet.