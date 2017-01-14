debug printing
printOop: oop

	| fmt lastIndex |
	<inline: false>
	self printNum: oop.
	(self isIntegerObject: oop) ifTrue:
		[^self cCode: 'printf("=%ld\n", (long)integerValueOf(oop))' inSmalltalk: [self shortPrint: oop]].
	self print: ': a(n) '.
	self printNameOfClass: (self fetchClassOf: oop) count: 5.
	self cr.
	fmt := self formatOf: oop.
	(fmt > 4 and: [fmt < 12]) ifTrue:
		[^self printStringOf: oop].
	lastIndex := 64 min: ((self lastPointerOf: oop) / self wordSize).
	lastIndex > 0 ifTrue:
		[1 to: lastIndex do:
			[:index|
			self cCode: 'printf(" %ld", fetchPointerofObject(index - 1, oop))'
				inSmalltalk: [self space; print: (self fetchPointer: index - 1 ofObject: oop) printString; space.
							 self print: (self shortPrint: (self fetchPointer: index - 1 ofObject: oop))].
			(index \\ 8) = 0 ifTrue:
				[self cr]].
		(lastIndex \\ 8) = 0 ifFalse:
			[self cr]]