primitive support
maybeInlinePositive32BitIntegerFor: integerValue
	"N.B. will *not* cause a GC.
	 integerValue is interpreted as POSITIVE, e.g. as the result of Bitmap>at:."
	<notOption: #Spur64BitMemoryManager>
	<var: 'integerValue' type: #'unsigned int'>
	| newLargeInteger |
	self deny: objectMemory hasSixtyFourBitImmediates.
       "force coercion because slang inliner sometimes incorrectly pass a signed int without converting to unsigned"
       (self cCode: [self cCoerceSimple: integerValue to: #'unsigned int']
			inSmalltalk: [integerValue bitAnd: 1 << 32 - 1]) <= objectMemory maxSmallInteger ifTrue:
		[^objectMemory integerObjectOf: integerValue].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: ClassLargePositiveIntegerCompactIndex
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	SPURVM
		ifTrue:
			["Memory is 8 byte aligned in Spur, make sure that oversized bytes are set to zero" "eem 4/28/2016 questionable; they should never be read"
			objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: integerValue).
			objectMemory storeLong32: 1 ofObject: newLargeInteger withValue: 0]
		ifFalse: 
			[objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: integerValue)].
	^newLargeInteger