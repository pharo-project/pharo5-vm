oop functions
normalizeNegative: aLargeNegativeInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| val val2 sLen digitLen byteLen oldByteLen minVal |
	<var: #val type: #usqInt>
	<var: #val2 type: #usqInt>
	<var: #minVal type: #usqInt>
	digitLen := self digitSizeOfLargeInt: aLargeNegativeInteger.
	[digitLen ~= 0 and: [(self unsafeDigitOfLargeInt: aLargeNegativeInteger at: digitLen) = 0]]
		whileTrue: [digitLen := digitLen - 1].
	digitLen = 0 ifTrue: [^ 0 asOop: SmallInteger].
	"Now check if in SmallInteger range"
	val := self unsafeDigitOfLargeInt: aLargeNegativeInteger at: digitLen.
	sLen := interpreterProxy minSmallInteger < -16r40000000
				ifTrue: [2]
				ifFalse: [1]. "SmallInteger minVal digitLength"
	digitLen <= sLen
		ifTrue: 
			[minVal := 0 - interpreterProxy minSmallInteger.
			val2 := val.
			digitLen > 1 ifTrue: [val2 := val2 << 32 + (self unsafeDigitOfLargeInt: aLargeNegativeInteger at: 1)].
			val2 <= minVal
				ifTrue: [^0 -  val2 asOop: SmallInteger]].
	"Return self, or a shortened copy"
	byteLen := digitLen * 4.
	val <= 16rFFFF
		ifTrue: [byteLen := byteLen - 2]
		ifFalse: [val := val >> 16].
	val <= 16rFF
		ifTrue: [byteLen := byteLen - 1].
	oldByteLen := self byteSizeOfLargeInt: aLargeNegativeInteger.
	byteLen < oldByteLen
		ifTrue: [^ self largeInt: aLargeNegativeInteger growTo: byteLen]
		ifFalse: [^ aLargeNegativeInteger]