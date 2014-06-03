primitives
primitiveAddPolygon
	| failureCode points lineFill lineWidth fillIndex nPoints length pointsIsArray segSize |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 5 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	lineFill := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	lineWidth := interpreterProxy stackIntegerValue: 1.
	fillIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 2).
	nPoints := interpreterProxy stackIntegerValue: 3.
	points := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 5)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	"First, do a check if the points look okay"
	length := interpreterProxy slotSizeOf: points.
	(interpreterProxy isWords: points) ifTrue:[
		pointsIsArray := false.
		"Either PointArray or ShortPointArray"
		(length = nPoints or:[nPoints * 2 = length])
			ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	] ifFalse:["Must be Array of points"
		(interpreterProxy isArray: points)
			ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
		length = nPoints
			ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
		pointsIsArray := true.
	].

	"Now check that we have some hope to have enough free space.
	Do this by assuming nPoints boundaries of maximum size,
	hoping that most of the fills will be colors and many boundaries
	will be line segments"

	(lineWidth = 0 or:[lineFill = 0])
		ifTrue:[segSize := GLBaseSize]
		ifFalse:[segSize := GLWideSize].
	(self needAvailableSpace: segSize * nPoints)
		ifFalse:[^interpreterProxy primitiveFail].

	"Check the fills"
	((self isFillOkay: lineFill) and:[self isFillOkay: fillIndex])
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill]. 

	"Transform colors"
	lineFill := self transformColor: lineFill.
	fillIndex := self transformColor: fillIndex.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	"Check if have anything at all to do"
	((lineFill = 0 or:[lineWidth = 0]) and:[fillIndex = 0])
		ifTrue:[^interpreterProxy pop: 5].

	"Transform the lineWidth"
	lineWidth = 0 ifFalse:[lineWidth := self transformWidth: lineWidth].

	"And load the actual polygon"
	pointsIsArray ifTrue:[
		self loadArrayPolygon: points nPoints: nPoints
			fill: fillIndex lineWidth: lineWidth lineFill: lineFill
	] ifFalse:[
		self loadPolygon: (interpreterProxy firstIndexableField: points) nPoints: nPoints 
			fill: fillIndex lineWidth: lineWidth lineFill: lineFill 
			pointsShort: (nPoints = length)].

	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self needsFlushPut: 1.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 5. "Leave rcvr on stack"