util
digitOf: oop at: ix 
	(interpreterProxy isIntegerObject: oop)
		ifTrue: [^ self cDigitOfCSI: (interpreterProxy integerValueOf: oop)
				at: ix]
		ifFalse: [^ self digitOfBytes: oop at: ix]