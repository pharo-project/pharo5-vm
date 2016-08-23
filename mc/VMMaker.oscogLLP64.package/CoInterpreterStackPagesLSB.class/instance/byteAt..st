memory access
byteAt: byteAddress
	| lowBits long |
	lowBits := byteAddress bitAnd: objectMemory wordSize - 1.
	long := self longAt: byteAddress - lowBits.
	lowBits > 0 ifTrue:
		[long := long bitShift: lowBits * -8].
	^long bitAnd: 16rFF