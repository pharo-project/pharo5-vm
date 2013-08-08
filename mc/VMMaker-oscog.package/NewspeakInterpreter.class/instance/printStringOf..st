debug printing
printStringOf: oop
	| fmt cnt i |
	<inline: false>
	(self isIntegerObject: oop) ifTrue:
		[^nil].
	(oop between: self startOfMemory and: freeBlock) ifFalse:
		[^nil].
	(oop bitAnd: (BytesPerWord - 1)) ~= 0 ifTrue:
		[^nil].
	fmt := self formatOf: oop.
	fmt < 8 ifTrue: [ ^nil ].

	cnt := 100 min: (self lengthOf: oop).
	i := 0.

	((self is: oop
		  instanceOf: (self splObj: ClassByteArray)
		  compactClassIndex: 0)
	or: [(self is: oop
			instanceOf: (self splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex)
	or: [(self is: oop
			instanceOf: (self splObj: ClassLargeNegativeInteger)
			compactClassIndex: ClassLargeNegativeIntegerCompactIndex)]])
		ifTrue:
			[[i < cnt] whileTrue: [
				self printHex: (self fetchByte: i ofObject: oop).
				i := i + 1]]
		ifFalse:
			[[i < cnt] whileTrue: [
				self printChar: (self fetchByte: i ofObject: oop).
				i := i + 1]].
	self flush