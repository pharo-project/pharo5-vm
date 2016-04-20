generate machine code
fillInOPICHeader: pic numArgs: numArgs selector: selector
	pic counters: 0.
	^super fillInOPICHeader: pic numArgs: numArgs selector: selector