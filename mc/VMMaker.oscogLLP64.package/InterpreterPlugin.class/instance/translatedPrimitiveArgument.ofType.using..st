simulation
translatedPrimitiveArgument: index ofType: cTypeString using: aCCodeGenerator
	| oop unitSize |
	oop := interpreterProxy stackValue: interpreterProxy methodArgumentCount - index.
	(interpreterProxy isOopForwarded: oop) ifTrue: [^nil]. 
	cTypeString last == $* ifTrue:
		[unitSize := self sizeof: (aCCodeGenerator baseTypeForPointerType: cTypeString) asSymbol.
		 unitSize caseOf: {
			[1]	->	[(interpreterProxy isBytes: oop) ifFalse: [^nil]].
			[2]	->	[(interpreterProxy isShorts: oop) ifFalse: [^nil]].
			[4]	->	[(interpreterProxy isWords: oop) ifFalse: [^nil]].
			[8]	->	[(interpreterProxy isLong64s: oop) ifFalse: [^nil]] }
			otherwise: [^nil].
		^ObjectProxyForTranslatedPrimitiveSimulation new
			interpreter: interpreterProxy
			oop: oop
			unitSize: unitSize].
	((interpreterProxy isIntegerObject: oop)
	 and: [aCCodeGenerator isIntegralCType: cTypeString]) ifTrue:
		[^interpreterProxy integerValueOf: oop].
	self halt