primitive support
noInlineSigned32BitIntegerFor: integerValue
	"Answer a full 32 bit integer object for the given integer value."
	<notOption: #Spur64BitMemoryManager>
	| newLargeInteger magnitude largeClass |
	<inline: false>
	<var: 'magnitude' type: 'unsigned int'>
	(objectMemory isIntegerValue: integerValue) ifTrue:
		[^objectMemory integerObjectOf: integerValue].
	self deny: objectMemory hasSixtyFourBitImmediates.
	 integerValue < 0
		ifTrue: [largeClass := ClassLargeNegativeIntegerCompactIndex.
				magnitude := 0 asUnsignedInteger - integerValue]
		ifFalse: [largeClass := ClassLargePositiveIntegerCompactIndex.
				magnitude := integerValue].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: largeClass
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	SPURVM
		ifTrue:
			["Memory is 8 byte aligned in Spur, make sure that oversized bytes are set to zero" "eem 4/28/2016 questionable; they should never be read"
			objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: magnitude).
			objectMemory storeLong32: 1 ofObject: newLargeInteger withValue: 0]
		ifFalse: 
			[objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: magnitude)].
	^newLargeInteger