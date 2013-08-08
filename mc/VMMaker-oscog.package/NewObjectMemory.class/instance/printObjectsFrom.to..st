debug printing
printObjectsFrom: startAddress to: endAddress
	<api>
	| oop |
	oop := startAddress.
	[oop < endAddress] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[self printOop: oop].
		oop := self objectAfter: oop].