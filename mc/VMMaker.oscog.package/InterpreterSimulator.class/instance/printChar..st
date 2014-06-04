debug printing
printChar: aByte

	traceOn ifTrue: [ transcript nextPut: aByte asCharacter ].