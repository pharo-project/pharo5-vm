debug printing
shortPrintObjectsFrom: startAddress to: endAddress
	<api>
	| oop |
	oop := self objectBefore: startAddress.
	oop := oop
				ifNil: [startAddress]
				ifNotNil: [(self objectAfter: oop) = startAddress
							ifTrue: [startAddress]
							ifFalse: [oop]].
	[self oop: oop isLessThan: endAddress] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[coInterpreter shortPrintOop: oop].
		oop := self objectAfter: oop]