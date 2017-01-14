generate machine code
fillInCPICHeader: pic numArgs: numArgs numCases: numCases hasMNUCase: hasMNUCase selector: selector
	pic counters: 0.
	^super fillInCPICHeader: pic numArgs: numArgs numCases: numCases hasMNUCase: hasMNUCase selector: selector