simulation only
isImmediate: anObject
	self flag: 'The float range is close but probably wrong. Revisit when immediate floats are implemented'.
	^(anObject isInteger and: [anObject between: self minSmallInteger and: self maxSmallInteger])
	  or: [anObject isCharacter
	  or: [anObject isFloat and: [anObject exponent between: -126 and: 127]]]

	"1.0e-38 exponent -127
	 1.0e38 exponent 126

	 NumberParser new makeFloatFromMantissa: 1 exponent: 127 base: 2 1.7014118346046923e38
	 (NumberParser new makeFloatFromMantissa: 1 exponent: 127 base: 2) exponent 127
	 NumberParser new makeFloatFromMantissa: 1 exponent: -126 base: 2 1.1754943508222875e-38
	 (NumberParser new makeFloatFromMantissa: 1 exponent: -126 base: 2) exponent -126"