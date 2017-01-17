primitives-other
primitiveRegisterExternalEdge
	| failureCode rightFillIndex leftFillIndex initialZ initialY initialX index  edge |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 6 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 6)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	rightFillIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	leftFillIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
	initialZ := interpreterProxy stackIntegerValue: 2.
	initialY := interpreterProxy stackIntegerValue: 3.
	initialX := interpreterProxy stackIntegerValue: 4.
	index := interpreterProxy stackIntegerValue: 5.
	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(self allocateObjEntry: GEBaseEdgeSize) 
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWorkTooBig].

	"Make sure the fills are okay"
	((self isFillOkay: leftFillIndex)
	and: [self isFillOkay: rightFillIndex])
		ifFalse:[^interpreterProxy primitiveFailFor: GEFWrongFill].

	edge := objUsed.
	objUsed := edge + GEBaseEdgeSize.
	"Install type and length"
	self objectTypeOf: edge put: GEPrimitiveEdge.
	self objectLengthOf: edge put: GEBaseEdgeSize.
	self objectIndexOf: edge put: index.
	"Install remaining stuff"
	self edgeXValueOf: edge put: initialX.
	self edgeYValueOf: edge put: initialY.
	self edgeZValueOf: edge put: initialZ.
	self edgeLeftFillOf: edge put: (self transformColor: leftFillIndex).
	self edgeRightFillOf: edge put: (self transformColor: rightFillIndex).
	engineStopped ifTrue:[^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed ifFalse:[
		self storeEngineStateInto: engine.
		interpreterProxy pop: 6. "Leave rcvr on stack"
	].