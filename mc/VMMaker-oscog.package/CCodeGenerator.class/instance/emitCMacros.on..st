C code generator
emitCMacros: methodList on: aStream 
	"Store the global variable declarations on the given stream."
	macros isEmpty ifTrue: [^self].
	aStream cr; nextPutAll: '/*** Macros ***/'; cr.

	(methodList reject: [:m| m isRealMethod]) do:
		[:m |
		m definedAsMacro ifTrue:
			[aStream
				nextPutAll: '#define ';
				nextPutAll:(self cFunctionNameFor: m selector);
				nextPutAll: (macros at: m selector); cr]].
	aStream cr