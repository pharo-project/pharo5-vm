primitives
primitiveAddRect
	| failureCode fillIndex borderWidth borderIndex endOop startOop |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 5 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	borderIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	borderWidth := interpreterProxy stackIntegerValue: 1.
	fillIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 2).
	endOop := interpreterProxy stackObjectValue: 3.
	startOop := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 5)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	"Make sure the fills are okay"
	((self isFillOkay: borderIndex) and:[self isFillOkay: fillIndex])
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].

	"Transform colors"
	borderIndex := self transformColor: borderIndex.
	fillIndex := self transformColor: fillIndex.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	"Check if we have anything at all to do"
	(fillIndex = 0 and:[borderIndex = 0 or:[borderWidth = 0]]) ifTrue:[
		^interpreterProxy pop: 5. "Leave rcvr on stack"
	].

	"Make sure we have some space"
	(self needAvailableSpace: (4 * GLBaseSize)) 
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWorkTooBig].

	"Check if we need a border"
	(borderWidth > 0 and:[borderIndex ~= 0]) 
		ifTrue:[borderWidth := self transformWidth: borderWidth]
		ifFalse:[borderWidth := 0].

	"Load the rectangle"
	self loadPoint: self point1Get from: startOop.
	self loadPoint: self point3Get from: endOop.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFBadPoint].
	self point2Get at: 0 put: (self point3Get at: 0).
	self point2Get at: 1 put: (self point1Get at: 1).
	self point4Get at: 0 put: (self point1Get at: 0).
	self point4Get at: 1 put: (self point3Get at: 1).
	"Transform the points"
	self transformPoints: 4.

	self loadRectangle: borderWidth lineFill: borderIndex leftFill: 0 rightFill: fillIndex.

	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self needsFlushPut: 1.
	self storeEngineStateInto: engine.
	interpreterProxy pop: 5. "Leave rcvr on stack"