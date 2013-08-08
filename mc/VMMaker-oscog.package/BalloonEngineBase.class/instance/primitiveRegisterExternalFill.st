primitives-other
primitiveRegisterExternalFill
	| failureCode index  fill |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 1)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	index := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	"Note: We *must* not allocate any fill with index 0"
	fill := 0.
	[fill = 0] whileTrue:[
		(self allocateObjEntry: GEBaseEdgeSize) 
			ifFalse:[^interpreterProxy primitiveFailFor: GEFWorkTooBig].
		fill := objUsed.
		objUsed := fill + GEBaseFillSize.
		"Install type and length"
		self objectTypeOf: fill put: GEPrimitiveFill.
		self objectLengthOf: fill put: GEBaseFillSize.
		self objectIndexOf: fill put: index.
	].

	interpreterProxy failed ifFalse:[
		self storeEngineStateInto: engine.
		interpreterProxy pop: 2.
		interpreterProxy pushInteger: fill.
	].