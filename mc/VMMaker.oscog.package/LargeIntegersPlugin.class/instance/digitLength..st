util
digitLength: oop 
	(interpreterProxy isIntegerObject: oop)
		ifTrue: [^ self cDigitLengthOfCSI: (interpreterProxy integerValueOf: oop)]
		ifFalse: [^ self byteSizeOfBytes: oop]