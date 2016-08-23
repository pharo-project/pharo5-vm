memory access
byteAt: byteAddress put: byte
	| lowBits long longAddress |
	self assert: (byte between: 0 and: 16rFF).
	lowBits := byteAddress bitAnd: objectMemory wordSize - 1.
	longAddress := byteAddress - lowBits.
	long := self longAt: longAddress.
	long := (long bitOr: (16rFF bitShift: lowBits * 8)) bitXor: (byte bitXor: 16rFF).
	self longAt: longAddress put: long.
	^byte