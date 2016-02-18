memory access
byteAt: byteAddress
	| lowBits long32 |
	lowBits := byteAddress bitAnd: 3.
	long32 := self long32At: byteAddress - lowBits.
	^(lowBits caseOf: {
		[0] -> [ long32 ].
		[1] -> [ long32 bitShift: -8  ].
		[2] -> [ long32 bitShift: -16 ].
		[3] -> [ long32 bitShift: -24 ].
	}) bitAnd: 16rFF