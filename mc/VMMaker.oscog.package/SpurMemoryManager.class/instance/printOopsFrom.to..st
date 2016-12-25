debug printing
printOopsFrom: startAddress to: endAddress
	<api>
	| oop limit |
	oop := self objectBefore: startAddress.
	limit := endAddress asUnsignedIntegerPtr min: endOfMemory.
	oop := oop
				ifNil: [startAddress]
				ifNotNil: [(self objectAfter: oop) = startAddress
							ifTrue: [startAddress]
							ifFalse: [oop]].
	[self oop: oop isLessThan: limit] whileTrue:
		[self printEntity: oop.
		 oop := self objectAfter: oop]