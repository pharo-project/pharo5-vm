memory access
byteAt: byteAddress
	| lowBits long64 |
	lowBits := byteAddress bitAnd: 7.
	long64 := self long64At: byteAddress - lowBits.
	^(long64 bitShift: -8 * lowBits) bitAnd: 16rFF