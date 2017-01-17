debug printing
printEntity: oop
	<api>
	| isObj |
	isObj := false.
	coInterpreter printHex: oop; space.
	(self addressCouldBeObj: oop) ifFalse:
		[^coInterpreter print: ((self isImmediate: oop) ifTrue: ['immediate'] ifFalse: ['unknown'])].
	coInterpreter
		print: ((self isFreeObject: oop) ifTrue: ['free'] ifFalse:
				[(self isSegmentBridge: oop) ifTrue: ['bridge'] ifFalse:
				[(self isForwarded: oop) ifTrue: ['forwarder'] ifFalse:
				[(self classIndexOf: oop) <= self lastClassIndexPun ifTrue: ['pun/obj stack'] ifFalse:
				[isObj := true. 'object']]]]);
		space; printHexnpnp: (self rawNumSlotsOf: oop); print: '/'; printHexnpnp: (self bytesInObject: oop); print: '/'; printNum: (self bytesInObject: oop).
	isObj ifTrue:
		[coInterpreter
			space;
			print: ((self formatOf: oop) <= 16rF ifTrue: ['f:0'] ifFalse: ['f:']);
			printHexnpnp: (self formatOf: oop);
			print: ((self isGrey: oop) ifTrue: [' g'] ifFalse: [' .']);
			print: ((self isImmutable: oop) ifTrue: ['i'] ifFalse: ['.']);
			print: ((self isMarked: oop) ifTrue: ['m'] ifFalse: ['.']);
			print: ((self isPinned: oop) ifTrue: ['p'] ifFalse: ['.']);
			print: ((self isRemembered: oop) ifTrue: ['r'] ifFalse: ['.'])].
	coInterpreter cr