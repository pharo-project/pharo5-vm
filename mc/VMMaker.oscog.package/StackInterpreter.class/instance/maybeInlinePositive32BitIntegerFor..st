primitive support
maybeInlinePositive32BitIntegerFor: integerValue
	"N.B. will *not* cause a GC.
	 integerValue is interpreted as POSITIVE, e.g. as the result of Bitmap>at:."
	<notOption: #Spur64BitMemoryManager>
	| newLargeInteger |
	self deny: objectMemory hasSixtyFourBitImmediates.
	(integerValue >= 0
	 and: [objectMemory isIntegerValue: integerValue]) ifTrue:
		[^objectMemory integerObjectOf: integerValue].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: ClassLargePositiveIntegerCompactIndex
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	objectMemory
		storeByte: 3 ofObject: newLargeInteger withValue: (integerValue >> 24 bitAnd: 16rFF);
		storeByte: 2 ofObject: newLargeInteger withValue: (integerValue >> 16 bitAnd: 16rFF);
		storeByte: 1 ofObject: newLargeInteger withValue: (integerValue >>   8 bitAnd: 16rFF);
		storeByte: 0 ofObject: newLargeInteger withValue: (integerValue ">> 0" bitAnd: 16rFF).
	^newLargeInteger