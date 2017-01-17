*VMMaker-JITSimulation
longAt: byteIndex put: aValue bigEndian: bigEndian
	"Compatibility with the ByteArray method of the same name."
	| lowBits wordIndex value mask |
	lowBits := byteIndex - 1 bitAnd: 3.
	wordIndex := byteIndex - 1 // 4 + 1.
	aValue < 0
		ifTrue:
			[value := 16rFFFFFFFF bitAnd: aValue.
			 value = 0 ifTrue:
				[self errorImproperStore]]
		ifFalse:
			[16rFFFFFFFF < aValue ifTrue:
				[self errorImproperStore].
			value := aValue].
	bigEndian ifFalse:
		[value := ((value bitShift: -24) bitAnd: 16rFF)
				 + ((value bitShift: -8) bitAnd: 16rFF00)
 				 + ((value bitAnd: 16rFF00) bitShift: 8)
				 + ((value bitAnd: 16rFF) bitShift: 24)].
	lowBits = 0 ifTrue:
		[self at: wordIndex put: value.
		 ^aValue].
	mask := 16rFFFFFFFF bitShift: lowBits * -8.
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask bitInvert) bitXor: ((value bitShift: lowBits * -8) bitAnd: mask)).
	self at: wordIndex + 1 put: (((self at: wordIndex + 1) bitAnd: mask) bitXor: (16rFFFFFFFF bitAnd: ((value bitShift: 4 - lowBits * 8) bitAnd: mask bitInvert))).
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