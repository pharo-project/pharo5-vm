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
		[coInterpreter
			printHex: oop; print: '/'; printNum: oop; space;
			print: ((self isFreeObject: oop) ifTrue: ['free'] ifFalse:
					[(self isSegmentBridge: oop) ifTrue: ['bridge'] ifFalse:
					[(self isForwarded: oop) ifTrue: ['forwarder'] ifFalse:
					['object']]]);
			cr.
		oop := self objectAfter: oop]