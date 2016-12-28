debug printing
printEntity: oop
	<api>
	coInterpreter printHex: oop; space.
	(self addressCouldBeObj: oop) ifFalse:
		[^coInterpreter print: ((self isImmediate: oop) ifTrue: ['immediate'] ifFalse: ['unknown'])].
	coInterpreter
		print: ((self isFreeObject: oop) ifTrue: ['free'] ifFalse:
				[(self isSegmentBridge: oop) ifTrue: ['bridge'] ifFalse:
				[(self isForwarded: oop) ifTrue: ['forwarder'] ifFalse:
				[(self classIndexOf: oop) <= self lastClassIndexPun ifTrue: ['pun/obj stack'] ifFalse:
				['object']]]]);
		space; printHex: (self bytesInObject: oop); print: '/'; printNum: (self bytesInObject: oop); cr