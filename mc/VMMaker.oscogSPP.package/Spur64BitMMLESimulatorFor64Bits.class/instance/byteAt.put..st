memory access
byteAt: byteAddress put: byte
	| lowBits long64 longAddress mask value |
	lowBits := byteAddress bitAnd: 7.
	longAddress := byteAddress - lowBits.
	long64 := self long64At: longAddress.
	mask := (16rFF bitShift: 8 * lowBits) bitInvert.
	value := byte bitShift: 8 * lowBits.
	self long64At: longAddress put: ((long64 bitAnd: mask) bitOr: value).
	^byte