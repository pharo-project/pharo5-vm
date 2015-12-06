C code generator
emitCMacros: methodList on: aStream 
	"Store the global variable declarations on the given stream.  Answer any constants used in the macros."
	| usedConstants |
	macros isEmpty ifTrue: [^#()].
	aStream cr; nextPutAll: '/*** Macros ***/'; cr.
	usedConstants := Set new.
	(methodList reject: [:m| m isRealMethod]) do:
		[:m |
		m definedAsMacro ifTrue:
			[aStream
				nextPutAll: '#define ';
				nextPutAll:(self cFunctionNameFor: m selector);
				nextPutAll: (macros at: m selector); cr.
			 m compiledMethod literalsDo:
				[:lit|
				(lit isVariableBinding and: [(macros at: m selector) includesSubString: lit key]) ifTrue:
					[usedConstants add: lit key]]]].
	aStream cr.
	^usedConstants