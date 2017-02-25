accessing
longAt: byteIndex bigEndian: bigEndian
	"Compatibility with the ByteArray method of the same name."
	| lowBits wordIndex value word0 word1 |
	lowBits := byteIndex - 1 bitAnd: 3.
	wordIndex := byteIndex - 1 // 4 + 1.
	lowBits = 0
		ifTrue:
			[value := self at: wordIndex]
		ifFalse:
			[word0 := self at: wordIndex.
			 word1 := self at: wordIndex + 1.
			 value := 16rFFFFFFFF bitAnd: (word0 bitShift: lowBits * -8) + (word1 bitShift: 4 - lowBits * 8)].
	bigEndian ifTrue:
		[value := ((value bitShift: -24) bitAnd: 16rFF)
				 + ((value bitShift: -8) bitAnd: 16rFF00)
 				 + ((value bitAnd: 16rFF00) bitShift: 8)
				 + ((value bitAnd: 16rFF) bitShift: 24)].
	(16r80000000 bitAnd: value) ~= 0 ifTrue:
		[value := (16r7FFFFFFF bitAnd: value) - 16r80000000].
	^value

	"| bm ba |
	(bm := LittleEndianBitmap new: 4)
		at: 1 put: 16r01234567;
		at: 2 put: 16r89ABCDEF;
		at: 3 put: 16r89ABCDEF;
		at: 4 put: 16r01234567.
	ba := bm asByteArray.
	(((1 to: 5), (9 to: 13) select:
		[:bi| (bm longAt: bi bigEndian: true) ~= (ba longAt: bi bigEndian: true)]) collect:
			[:i| { i. (bm longAt: i bigEndian: true) hex. (ba longAt: i bigEndian: true) hex}]),
	(((1 to: 5), (9 to: 13) select:
		[:bi| (bm longAt: bi bigEndian: false) ~= (ba longAt: bi bigEndian: false)]) collect:
			[:i| { i. (bm longAt: i bigEndian: false) hex. (ba longAt: i bigEndian: false) hex}])"