util
digitOf: oop at: ix 
	(interpreterProxy isIntegerObject: oop) ifTrue:
		[ix < 1 ifTrue: [interpreterProxy primitiveFail. ^0].
		 ix > interpreterProxy bytesPerOop ifTrue: [^0].
		 ^self cDigitOfCSI: (interpreterProxy integerValueOf: oop) at: ix].
	^self digitOfBytes: oop at: ix