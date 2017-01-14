printing
printHex: anInteger
	| it16 |
	it16 := anInteger radix: 16.
	coInterpreter transcript
		next: 8 - it16 size put: Character space;
		nextPutAll: (anInteger printStringBase: 16)