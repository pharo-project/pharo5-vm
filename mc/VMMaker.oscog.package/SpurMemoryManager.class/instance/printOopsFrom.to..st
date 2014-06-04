debug printing
printOopsFrom: startAddress to: endAddress
	<api>
	| oop |
	oop := self objectBefore: startAddress.
	oop := oop
				ifNil: [startAddress]
				ifNotNil: [(self objectAfter: oop) = startAddress
							ifTrue: [startAddress]
							ifFalse: [oop]].
	[self oop: oop isLessThan: endAddress] whileTrue:
		[coInterpreter
			printHex: oop; print: '/'; printNum: oop; space;
			print: ((self isFreeObject: oop) ifTrue: ['free'] ifFalse:
					[(self isSegmentBridge: oop) ifTrue: ['bridge'] ifFalse:
					[(self isForwarded: oop) ifTrue: ['forwarder'] ifFalse:
					['object']]]);
			cr.
		oop := self objectAfter: oop]