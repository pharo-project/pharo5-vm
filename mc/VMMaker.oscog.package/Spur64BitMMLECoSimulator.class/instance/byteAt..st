memory access
byteAt: byteAddress
	| lowBits long32 |
	lowBits := byteAddress bitAnd: 3.
	long32 := self long32At: byteAddress - lowBits.
	^(long32 bitShift: -8 * lowBits) bitAnd: 16rFF