memory access
byteAt: byteAddress put: byte
	| lowBits long32 longAddress mask value |
	lowBits := byteAddress bitAnd: 3.
	longAddress := byteAddress - lowBits.
	long32 := self long32At: longAddress.
	mask := (16rFF bitShift: 8 * lowBits) bitInvert.
	value := byte bitShift: 8 * lowBits.
	self long32At: longAddress put: ((long32 bitAnd: mask) bitOr: value).
	^byte