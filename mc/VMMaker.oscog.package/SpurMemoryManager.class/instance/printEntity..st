debug printing
printEntity: oop
	coInterpreter
		printHex: oop; print: '/'; printNum: oop; space;
		print: ((self isFreeObject: oop) ifTrue: ['free'] ifFalse:
				[(self isSegmentBridge: oop) ifTrue: ['bridge'] ifFalse:
				[(self isForwarded: oop) ifTrue: ['forwarder'] ifFalse:
				['object']]]);
		space; printHex: (self bytesInObject: oop); print: '/'; printNum: (self bytesInObject: oop); cr