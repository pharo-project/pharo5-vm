primitive support
positive64BitIntegerFor: integerValue
	<api>
	<var: 'integerValue' type: #usqLong>
	<var: 'highWord' type: #'unsigned int'>
	"Answer a Large Positive Integer object for the given integer value.  N.B. will *not* cause a GC."
	| newLargeInteger highWord sz |
	objectMemory hasSixtyFourBitImmediates
		ifTrue:
			[(self cCode: [integerValue] inSmalltalk: [integerValue bitAnd: 1 << 64 - 1]) <= objectMemory maxSmallInteger ifTrue:
				[^objectMemory integerObjectOf: integerValue].
			 sz := 8]
		ifFalse:
			[(highWord := integerValue >> 32) = 0 ifTrue:
				[^self positive32BitIntegerFor: integerValue].
			 sz := 5.
			 (highWord := highWord >> 8) = 0 ifFalse:
				[sz := sz + 1.
				 (highWord := highWord >> 8) = 0 ifFalse:
					[sz := sz + 1.
					 (highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1]]]].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: ClassLargePositiveIntegerCompactIndex
							format: (objectMemory byteFormatForNumBytes: sz)
							numSlots: 8 / objectMemory bytesPerOop.
	objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped64IfBigEndian: integerValue).
	^newLargeInteger
