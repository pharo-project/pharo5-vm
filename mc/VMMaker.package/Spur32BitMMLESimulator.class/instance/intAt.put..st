memory access
intAt: byteAddress put: a32BitValue
	^self longAt: byteAddress put: (a32BitValue bitAnd: 16rFFFFFFFF)