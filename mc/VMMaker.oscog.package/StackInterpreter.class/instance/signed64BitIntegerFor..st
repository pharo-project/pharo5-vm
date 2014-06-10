primitive support
signed64BitIntegerFor: integerValue
	<var: 'integerValue' type: #sqLong>
	"Answer a Large Integer object for the given integer value.  N.B. will *not* cause a GC."
	| newLargeInteger magnitude largeClass highWord sz |
	<inline: false>
	<var: 'magnitude' type: #sqLong>
	<var: 'highWord' type: #usqInt>

	integerValue < 0
		ifTrue:[	largeClass := ClassLargeNegativeIntegerCompactIndex.
				magnitude := 0 - integerValue]
		ifFalse:[	largeClass := ClassLargePositiveIntegerCompactIndex.
				magnitude := integerValue].

	"Make sure to handle the most -ve value correctly. 0 - most -ve = most -ve and most -ve - 1
	 is +ve.  Alas the simple (negative or: [integerValue - 1 < 0]) fails with contemporary gcc and icc
	 versions with optimization and sometimes without.  The shift works on all, touch wood."
	(magnitude <= 16r7FFFFFFF
	 and: [integerValue >= 0
		  or: [0 ~= (self cCode: [integerValue << 1]
						inSmalltalk: [integerValue << 1 bitAnd: (1 << 64) - 1])]]) ifTrue:
			[^self signed32BitIntegerFor: integerValue].

	highWord := magnitude >> 32.
	highWord = 0 
		ifTrue:[sz := 4] 
		ifFalse:
			[sz := 5.
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1]].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: largeClass
							format: (objectMemory byteFormatForNumBytes: sz)
							numSlots: sz + 3 // objectMemory bytesPerSlot.
	sz > 4 ifTrue:
		[objectMemory
			storeByte: 7 ofObject: newLargeInteger withValue: (magnitude >> 56 bitAnd: 16rFF);
			storeByte: 6 ofObject: newLargeInteger withValue: (magnitude >> 48 bitAnd: 16rFF);
			storeByte: 5 ofObject: newLargeInteger withValue: (magnitude >> 40 bitAnd: 16rFF);
			storeByte: 4 ofObject: newLargeInteger withValue: (magnitude >> 32 bitAnd: 16rFF)].
	objectMemory
		storeByte: 3 ofObject: newLargeInteger withValue: (magnitude >> 24 bitAnd: 16rFF);
		storeByte: 2 ofObject: newLargeInteger withValue: (magnitude >> 16 bitAnd: 16rFF);
		storeByte: 1 ofObject: newLargeInteger withValue: (magnitude >>   8 bitAnd: 16rFF);
		storeByte: 0 ofObject: newLargeInteger withValue: (magnitude ">> 0" bitAnd: 16rFF).
	^newLargeInteger