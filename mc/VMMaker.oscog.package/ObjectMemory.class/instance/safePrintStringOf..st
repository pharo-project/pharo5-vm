debug printing
safePrintStringOf: oop
	"Version of printStringOf: that copes with forwarding during garbage collection."
	| fmt header cnt i |
	<inline: false>
	(self isIntegerObject: oop) ifTrue:
		[^nil].
	(self oop: oop isGreaterThanOrEqualTo: self startOfMemory andLessThan: freeBlock) ifFalse:
		[^nil].
	(oop bitAnd: (self wordSize - 1)) ~= 0 ifTrue:
		[^nil].
	header := self headerWhileForwardingOf: oop.
	fmt := self formatOfHeader: header.
	fmt < self firstByteFormat ifTrue: [^nil].

	cnt := 100 min: (self lengthOf: oop baseHeader: header format: fmt).
	i := 0.

	[i < cnt] whileTrue:
		[self printChar: (self fetchByte: i ofObject: oop).
		 i := i + 1].
	self flush.
	^oop