debug printing
printObjectsFrom: startAddress to: endAddress
	<api>
	| oop |
	oop := startAddress.
	[self oop: oop isLessThan: endAddress] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[coInterpreter printOop: oop].
		oop := self objectAfter: oop].