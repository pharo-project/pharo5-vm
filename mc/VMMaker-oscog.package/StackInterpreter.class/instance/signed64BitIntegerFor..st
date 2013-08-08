primitive support
signed64BitIntegerFor: integerValue
	"Return a Large Integer object for the given integer value"
	| newLargeInteger magnitude largeClass intValue highWord sz |
	<inline: false>
	<var: 'integerValue' type: #sqLong>
	<var: 'magnitude' type: #sqLong>
	<var: 'highWord' type: #usqInt>

	integerValue < 0
		ifTrue:[	largeClass := objectMemory classLargeNegativeInteger.
				magnitude := 0 - integerValue]
		ifFalse:[	largeClass := objectMemory classLargePositiveInteger.
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
	newLargeInteger := objectMemory instantiateClass: largeClass indexableSize:  sz.
	0 to: sz-1 do: [:i |
		intValue := (magnitude >> (i * 8)) bitAnd: 255.
		objectMemory storeByte: i ofObject: newLargeInteger withValue: intValue].
	^newLargeInteger