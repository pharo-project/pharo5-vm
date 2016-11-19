memory access
shortAt: byteAddress put: short
	| lowBits long64 longAddress mask value |
	lowBits := byteAddress bitAnd: 6.
	longAddress := byteAddress - lowBits.
	long64 := self long64At: longAddress.
	mask := (16rFFFF bitShift: 8 * lowBits) bitInvert.
	value := short bitShift: 8 * lowBits.
	self long64At: longAddress put: ((long64 bitAnd: mask) bitOr: value).
	^short