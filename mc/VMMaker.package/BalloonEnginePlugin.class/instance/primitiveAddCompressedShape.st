primitives
primitiveAddCompressedShape
	| failureCode fillIndexList lineFills lineWidths rightFills leftFills nSegments points pointsShort |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 7 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	fillIndexList := interpreterProxy stackObjectValue: 0.
	lineFills := interpreterProxy stackObjectValue: 1.
	lineWidths := interpreterProxy stackObjectValue: 2.
	rightFills := interpreterProxy stackObjectValue: 3.
	leftFills := interpreterProxy stackObjectValue: 4.
	nSegments := interpreterProxy stackIntegerValue: 5.
	points := interpreterProxy stackObjectValue: 6.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 7)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	"First, do a check if the compressed shape is okay"
	(self checkCompressedShape: points 
			segments: nSegments 
			leftFills: leftFills 
			rightFills: rightFills 
			lineWidths: lineWidths 
			lineFills: lineFills 
			fillIndexList: fillIndexList) ifFalse:[^interpreterProxy primitiveFailFor: GEFEntityCheckFailed].

	"Now check that we have some hope to have enough free space.
	Do this by assuming nSegments boundaries of maximum size,
	hoping that most of the fills will be colors and many boundaries
	will be line segments"

	(self needAvailableSpace: (GBBaseSize max: GLBaseSize) * nSegments)
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWorkTooBig].

	"Check if the points are short"
	pointsShort := (interpreterProxy slotSizeOf: points) = (nSegments * 3).

	"Then actually load the compressed shape"
	self loadCompressedShape: (interpreterProxy firstIndexableField: points)
			segments: nSegments 
			leftFills: (interpreterProxy firstIndexableField: leftFills)
			rightFills: (interpreterProxy firstIndexableField: rightFills)
			lineWidths: (interpreterProxy firstIndexableField: lineWidths)
			lineFills: (interpreterProxy firstIndexableField: lineFills)
			fillIndexList: (interpreterProxy firstIndexableField: fillIndexList)
			pointShort: pointsShort.

	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self needsFlushPut: 1.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 7. "Leave rcvr on stack"