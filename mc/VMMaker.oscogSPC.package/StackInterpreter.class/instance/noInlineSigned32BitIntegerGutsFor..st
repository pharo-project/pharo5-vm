primitive support
noInlineSigned32BitIntegerGutsFor: integerValue
	"Answer a full 32 bit integer object for the given integer value which
	 is known not to be a SmallInteger value.  This serves to share the
	 code for creating a four byte LargeInteger in one place."
	<notOption: #Spur64BitMemoryManager>
	| newLargeInteger magnitude largeClass |
	<inline: #never>
	<var: #magnitude type: #'unsigned int'>
	self deny: objectMemory hasSixtyFourBitImmediates.
	self deny: (objectMemory isIntegerValue: integerValue).
	 integerValue < 0
		ifTrue: [largeClass := ClassLargeNegativeIntegerCompactIndex.
				magnitude := 0 asUnsignedInteger - integerValue]
		ifFalse: [largeClass := ClassLargePositiveIntegerCompactIndex.
				magnitude := integerValue].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: largeClass
							format: (objectMemory byteFormatForNumBytes: 4)
							numSlots: 1.
	objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: magnitude).
	SPURVM ifTrue: "Memory is 8 byte aligned in Spur, make sure that oversized bytes are set to zero" "eem 4/28/2016 questionable; they should never be read"
		[objectMemory storeLong32: 1 ofObject: newLargeInteger withValue: 0].
	^newLargeInteger