primitive support
noInlineSigned32BitIntegerFor: integerValue
	"Answer a full 32 bit integer object for the given integer value."
	<notOption: #Spur64BitMemoryManager>
	| newLargeInteger value largeClass |
	<inline: false>
	(objectMemory isIntegerValue: integerValue) ifTrue:
		[^objectMemory integerObjectOf: integerValue].
	self deny: objectMemory hasSixtyFourBitImmediates.
	 integerValue < 0
		ifTrue: [largeClass := ClassLargeNegativeIntegerCompactIndex.
				value := 0 - integerValue]
		ifFalse: [largeClass := ClassLargePositiveIntegerCompactIndex.
				value := integerValue].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: largeClass
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	self cppIf: VMBIGENDIAN
		ifTrue:
			[objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: value byteSwap32]
		ifFalse:
			[objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: value].
	^newLargeInteger