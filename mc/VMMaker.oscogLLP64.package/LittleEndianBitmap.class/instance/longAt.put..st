accessing
longAt: byteIndex put: aValue
	"Compatibility with the ByteArray method of the same name."
	| lowBits wordIndex mask |
	lowBits := byteIndex - 1 bitAnd: 3.
	wordIndex := byteIndex - 1 // 4 + 1.
	aValue < 0
		ifTrue:
			[aValue < -2147483648 ifTrue:
				[^self errorImproperStore]]
		ifFalse:
			[16r7FFFFFFF < aValue ifTrue:
				[^self errorImproperStore]].
	lowBits = 0 ifTrue:
		[self at: wordIndex put: (16rFFFFFFFF bitAnd: aValue).
		 ^aValue].
	mask := 16rFFFFFFFF bitShift: lowBits * -8.
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask) bitXor: ((aValue bitShift: lowBits * 8) bitAnd: mask bitInvert32)).
	self at: wordIndex + 1 put: (((self at: wordIndex + 1) bitAnd: mask bitInvert32) bitXor: ((aValue bitShift: 4 - lowBits * -8) bitAnd: mask)).
	^aValue

	"(1 to: 8) collect:
		[:ba| | bm |
		bm := LittleEndianBitmap new: 4.
		bm at: 1 put: 16r55555555.
		bm at: 2 put: 16rAAAAAAAA.
		bm longAt: ba put: 16r04030201.
		{ (bm at: 1) hex. (bm at: 2) hex }]"