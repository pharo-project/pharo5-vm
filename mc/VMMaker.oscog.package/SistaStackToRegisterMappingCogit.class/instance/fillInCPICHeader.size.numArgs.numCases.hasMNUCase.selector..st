generate machine code
fillInCPICHeader: pic size: size numArgs: numArgs numCases: numCases hasMNUCase: hasMNUCase selector: selector
	pic counters: 0.
	^super fillInCPICHeader: pic size: size numArgs: numArgs numCases: numCases hasMNUCase: hasMNUCase selector: selector