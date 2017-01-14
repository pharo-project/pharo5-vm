debug printing
printStringOf: oop

	| fmt cnt i |
	(self isIntegerObject: oop) ifTrue:[^nil].
	fmt := self formatOf: oop.
	fmt < 8 ifTrue: [ ^nil ].

	cnt := 100 min: (self lengthOf: oop).
	i := 0.
	[i < cnt] whileTrue: [
		self printChar: (self fetchByte: i ofObject: oop).
		i := i + 1.
	].
	self cCode: 'fflush(stdout)' inSmalltalk: []