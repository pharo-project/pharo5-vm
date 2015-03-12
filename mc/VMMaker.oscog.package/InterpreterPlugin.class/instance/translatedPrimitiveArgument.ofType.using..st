simulation
translatedPrimitiveArgument: index ofType: cTypeString using: aCCodeGenerator
	| oop |
	oop := interpreterProxy stackValue: interpreterProxy methodArgumentCount - index.
	cTypeString last == $* ifTrue:
		[^ObjectProxyForTranslatedPrimitiveSimulation new
			interpreter: interpreterProxy
			oop: oop
			unitSize: (self sizeof: (aCCodeGenerator baseTypeForPointerType: cTypeString) asSymbol)].
	((interpreterProxy isIntegerObject: oop)
	 and: [aCCodeGenerator isIntegralCType: cTypeString]) ifTrue:
		[^interpreterProxy integerValueOf: oop].
	self halt