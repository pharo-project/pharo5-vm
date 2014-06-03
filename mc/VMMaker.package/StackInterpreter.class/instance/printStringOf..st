debug printing
printStringOf: oop
	| fmt len cnt max i |
	<inline: false>
	(objectMemory isImmediate: oop) ifTrue:
		[^nil].
	(objectMemory addressCouldBeObj: oop) ifFalse:
		[^nil].
	fmt := objectMemory formatOf: oop.
	fmt < objectMemory firstByteFormat ifTrue: [^nil].

	cnt := (max := 128) min: (len := objectMemory lengthOf: oop).
	i := 0.

	((objectMemory is: oop
		  instanceOf: (objectMemory splObj: ClassByteArray)
		  compactClassIndex: classByteArrayCompactIndex)
	or: [(self isInstanceOfClassLargePositiveInteger: oop)
	or: [(self isInstanceOfClassLargeNegativeInteger: oop)]])
		ifTrue:
			[[i < cnt] whileTrue:
				[self printHex: (objectMemory fetchByte: i ofObject: oop).
				 i := i + 1]]
		ifFalse:
			[[i < cnt] whileTrue:
				[self printChar: (objectMemory fetchByte: i ofObject: oop).
				 i := i + 1]].
	len > max ifTrue:
		[self print: '...'].
	self flush