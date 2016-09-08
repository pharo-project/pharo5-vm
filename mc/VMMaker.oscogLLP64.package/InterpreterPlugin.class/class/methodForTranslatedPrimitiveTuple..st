translated primitives
methodForTranslatedPrimitiveTuple: tuple
	| class |
	class := Smalltalk classNamed: tuple first.
	^class
		compiledMethodAt: tuple last
		ifAbsent: [class class compiledMethodAt: tuple last]