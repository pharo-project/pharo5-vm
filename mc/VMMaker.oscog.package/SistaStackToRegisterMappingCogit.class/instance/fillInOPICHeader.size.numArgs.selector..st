generate machine code
fillInOPICHeader: pic size: size numArgs: numArgs selector: selector
	pic counters: 0.
	^super fillInOPICHeader: pic size: size numArgs: numArgs selector: selector