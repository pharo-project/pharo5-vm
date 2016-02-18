debug printing
printStringOf: oop on: aStream
	| fmt cnt i |
	(objectMemory isIntegerObject: oop) ifTrue:
		[^nil].
	(oop between: objectMemory startOfMemory and: objectMemory freeStart) ifFalse:
		[^nil].
	(oop bitAnd: (objectMemory wordSize - 1)) ~= 0 ifTrue:
		[^nil].
	fmt := objectMemory formatOf: oop.
	fmt < 8 ifTrue: [ ^nil ].

	cnt := 100 min: (objectMemory lengthOf: oop).
	i := 0.
	[i < cnt] whileTrue: [
		aStream nextPut: (Character value: (objectMemory fetchByte: i ofObject: oop)).
		i := i + 1.
	].
	aStream flush