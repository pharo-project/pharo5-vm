primitive support
positive32BitIntegerFor: integerValue
	| newLargeInteger |
	"Note - integerValue is interpreted as POSITIVE, eg, as the result of Bitmap>at:, or integer>bitAnd:."
	(integerValue >= 0
	 and: [objectMemory isIntegerValue: integerValue]) ifTrue:
		[^objectMemory integerObjectOf: integerValue].

	newLargeInteger := objectMemory
							eeInstantiateClassIndex: ClassLargePositiveIntegerCompactIndex
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	objectMemory
		storeByte: 3 ofObject: newLargeInteger withValue: (integerValue >> 24 bitAnd: 16rFF);
		storeByte: 2 ofObject: newLargeInteger withValue: (integerValue >> 16 bitAnd: 16rFF);
		storeByte: 1 ofObject: newLargeInteger withValue: (integerValue >>   8 bitAnd: 16rFF);
		storeByte: 0 ofObject: newLargeInteger withValue: (integerValue ">> 0" bitAnd: 16rFF).
	^newLargeInteger