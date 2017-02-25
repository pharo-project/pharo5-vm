oop functions
normalizePositive: aLargePositiveInteger 
	"Check for leading zeroes and return shortened copy if so."
	"First establish len = significant length."
	| val val2 sLen digitLen byteLen oldByteLen maxVal |
	<var: #val type: #usqInt>
	<var: #val2 type: #usqInt>
	<var: #maxVal type: #usqInt>
	digitLen := self digitSizeOfLargeInt: aLargePositiveInteger.
	[digitLen ~= 0 and: [(self unsafeDigitOfLargeInt: aLargePositiveInteger at: digitLen) = 0]]
		whileTrue: [digitLen := digitLen - 1].
	digitLen = 0 ifTrue: [^ 0 asOop: SmallInteger].
	"Now check if in SmallInteger range"
	val := self unsafeDigitOfLargeInt: aLargePositiveInteger at: digitLen.
	sLen := interpreterProxy maxSmallInteger > 16r3FFFFFFF
				ifTrue: [2]
				ifFalse: [1]. "SmallInteger maxVal digitLength"
	digitLen <= sLen
		ifTrue: 
			[maxVal := interpreterProxy maxSmallInteger.
			val2 := val.
			digitLen > 1 ifTrue:
				["Note: asUnsignedLongLong is not necessary because this branch is for 64 bits only.
				but we want to avoid a C Compiler warning on 32 bits"
				val2 := val2 asUnsignedLongLong << 32 + (self unsafeDigitOfLargeInt: aLargePositiveInteger at: 1)].
			val2 <= maxVal
				ifTrue: [^val2 asOop: SmallInteger]].
	"Return self, or a shortened copy"
	byteLen := digitLen * 4.
	val <= 16rFFFF
		ifTrue: [byteLen := byteLen - 2]
		ifFalse: [val := val >> 16].
	val <= 16rFF
		ifTrue: [byteLen := byteLen - 1].
	oldByteLen := self byteSizeOfLargeInt: aLargePositiveInteger.
	byteLen < oldByteLen
		ifTrue: [^ self largeInt: aLargePositiveInteger growTo: byteLen]
		ifFalse: [^ aLargePositiveInteger]