primitives-rendering
proceedRenderingImage
	"This is the main rendering entry"
	| external |
	<inline: false>
	[self finishedProcessing] whileFalse:[
		doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
		external := self findNextExternalEntryFromGET.
		doProfileStats ifTrue:[
			self incrementStat: GWCountNextGETEntry by: 1.
			self incrementStat: GWTimeNextGETEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
		engineStopped ifTrue:[^self statePut: GEStateAddingFromGET].
		external ifTrue:[
			self statePut: GEStateWaitingForEdge.
			^self stopBecauseOf: GErrorGETEntry.
		]. 
		self aetStartPut: 0.
		self wbStackClear.
		self clearSpanBufferPut: 1.

		doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
		(self clearSpanBufferGet ~= 0 and:[(self currentYGet bitAnd: self aaScanMaskGet) = 0])
			ifTrue:[self clearSpanBuffer].
		self clearSpanBufferPut: 0.
		external := self findNextExternalFillFromAET.
		doProfileStats ifTrue:[
			self incrementStat: GWCountNextFillEntry by: 1.
			self incrementStat: GWTimeNextFillEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
		engineStopped ifTrue:[^self statePut: GEStateScanningAET].
		external ifTrue:[
			self statePut: GEStateWaitingForFill.
			^self stopBecauseOf: GErrorFillEntry.
		].
		self wbStackClear.
		self spanEndAAPut: 0.

		doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
		(self currentYGet bitAnd: self aaScanMaskGet) = self aaScanMaskGet ifTrue:[
			self displaySpanBufferAt: self currentYGet.
			self postDisplayAction.
		].
		doProfileStats ifTrue:[
			self incrementStat: GWCountDisplaySpan by: 1.
			self incrementStat: GWTimeDisplaySpan by: (interpreterProxy ioMicroMSecs - geProfileTime)].
		engineStopped ifTrue:[^self statePut: GEStateBlitBuffer].
		self finishedProcessing ifTrue:[^0].
		self aetStartPut: 0.
		self currentYPut: self currentYGet + 1.

		doProfileStats ifTrue:[geProfileTime := interpreterProxy ioMicroMSecs].
		external := self findNextExternalUpdateFromAET.
		doProfileStats ifTrue:[
			self incrementStat: GWCountNextAETEntry by: 1.
			self incrementStat: GWTimeNextAETEntry by: (interpreterProxy ioMicroMSecs - geProfileTime)].
		engineStopped ifTrue:[^self statePut: GEStateUpdateEdges].
		external ifTrue:[
			self statePut: GEStateWaitingChange.
			^self stopBecauseOf: GErrorAETEntry.
		].
	].