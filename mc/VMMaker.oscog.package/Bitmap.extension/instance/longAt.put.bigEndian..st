*VMMaker-JITSimulation
longAt: byteIndex put: aValue bigEndian: bigEndian
	"Compatibility with the ByteArray method of the same name."
	| lowBits wordIndex value mask |
	lowBits := byteIndex - 1 bitAnd: 3.
	wordIndex := byteIndex - 1 // 4 + 1.
	value := aValue < 0
				ifTrue: [16rFFFFFFFF bitAnd: value]
				ifFalse: [16rFFFFFFFF < aValue ifTrue:
							[self errorImproperStore].
						aValue].
	bigEndian ifFalse:
		[value := (value >> 24 bitAnd: 16rFF)
				 + (value >> 8 bitAnd: 16rFF00)
 				 + ((value bitAnd: 16rFF00) << 8)
				 + ((value bitAnd: 16rFF) << 24)].
	lowBits = 0 ifTrue:
		[self at: wordIndex put: value.
		 ^aValue].
	mask := 16rFFFFFFFF bitAnd: 16rFFFFFFFF >> (lowBits * 8).
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask bitInvert) bitXor: (value >> (lowBits * 8) bitAnd: mask)).
	self at: wordIndex + 1 put: (((self at: wordIndex + 1) bitAnd: mask) bitXor: (16rFFFFFFFF bitAnd: (value << (4 - lowBits * 8) bitAnd: mask bitInvert))).
	^aValue

	"(1 to: 8) collect:
		[:ba| | bm |
		bm := Bitmap new: 4.
		bm at: 1 put: 16r55555555.
		bm at: 2 put: 16rAAAAAAAA.
		bm longAt: ba put: 16r04030201 bigEndian: true.
		{ (bm at: 1) hex. (bm at: 2) hex }]"

	"(1 to: 8) collect:
		[:ba| | bm |
		bm := Bitmap new: 4.
		bm at: 1 put: 16r55555555.
		bm at: 2 put: 16rAAAAAAAA.
		bm longAt: ba put: 16r01020304 bigEndian: false.
		{ (bm at: 1) hex. (bm at: 2) hex }]"