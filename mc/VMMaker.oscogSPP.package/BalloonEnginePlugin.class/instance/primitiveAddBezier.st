primitives
primitiveAddBezier
	| failureCode leftFill rightFill viaOop endOop startOop nSegments |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 5 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	rightFill := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	leftFill := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
	viaOop := interpreterProxy stackObjectValue: 2.
	endOop := interpreterProxy stackObjectValue: 3.
	startOop := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 5)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	"Make sure the fills are okay"
	((self isFillOkay: leftFill) and:[self isFillOkay: rightFill])
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].

	"Do a quick check if the fillIndices are equal - if so, just ignore it"
	leftFill = rightFill & false ifTrue:[
		^interpreterProxy pop: 6. "Leave rcvr on stack"
	].


	self loadPoint: self point1Get from: startOop.
	self loadPoint: self point2Get from: viaOop.
	self loadPoint: self point3Get from: endOop.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	self transformPoints: 3.

	nSegments := self loadAndSubdivideBezierFrom: self point1Get 
						via: self point2Get 
						to: self point3Get 
						isWide: false.
	self needAvailableSpace: nSegments * GBBaseSize.
	engineStopped ifFalse:[
		leftFill := self transformColor: leftFill.
		rightFill := self transformColor: rightFill].
	engineStopped ifFalse:[
		self loadWideBezier: 0 lineFill: 0 leftFill: leftFill rightFill: rightFill n: nSegments.
	].
	engineStopped ifTrue:[
		"Make sure the stack is okay"
		self wbStackClear.
		^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 5. "Leave rcvr on stack"