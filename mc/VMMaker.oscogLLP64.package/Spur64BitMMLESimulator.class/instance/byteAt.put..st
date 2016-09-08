memory access
byteAt: byteAddress put: byte
	| lowBits long32 longAddress |
	lowBits := byteAddress bitAnd: 3.
	longAddress := byteAddress - lowBits.
	long32 := self long32At: longAddress.
	long32 := (lowBits caseOf: {
		[0] -> [ (long32 bitAnd: 16rFFFFFF00) bitOr: byte ].
		[1] -> [ (long32 bitAnd: 16rFFFF00FF) bitOr: (byte bitShift: 8) ].
		[2] -> [ (long32 bitAnd: 16rFF00FFFF) bitOr: (byte bitShift: 16) ].
		[3] -> [ (long32 bitAnd: 16r00FFFFFF) bitOr: (byte bitShift: 24) ].
	}).
	self long32At: longAddress put: long32.
	^byte