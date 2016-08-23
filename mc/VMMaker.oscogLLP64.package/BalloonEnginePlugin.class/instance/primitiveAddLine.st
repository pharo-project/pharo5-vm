primitives
primitiveAddLine
	| failureCode leftFill rightFill endOop startOop |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 4 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	rightFill := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	leftFill := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
	endOop := interpreterProxy stackObjectValue: 2.
	startOop := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 4)
			requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	"Make sure the fills are okay"
	((self isFillOkay: leftFill) and:[self isFillOkay: rightFill])
			ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].

	"Load the points"
	self loadPoint: self point1Get from: startOop.
	self loadPoint: self point2Get from: endOop.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFBadPoint].

	"Transform points"
	self transformPoints: 2.

	"Transform colors"
	leftFill := self transformColor: leftFill.
	rightFill := self transformColor: rightFill.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	"Load line"
	self loadWideLine: 0 from: self point1Get to: self point2Get 
		lineFill: 0 leftFill: leftFill rightFill: rightFill.
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 4. "Leave rcvr on stack"