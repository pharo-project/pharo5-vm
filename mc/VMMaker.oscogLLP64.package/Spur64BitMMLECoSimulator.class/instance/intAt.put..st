memory access
intAt: byteAddress put: a64BitValue
	^self long32At: byteAddress put: (a64BitValue bitAnd: 16rFFFFFFFF)