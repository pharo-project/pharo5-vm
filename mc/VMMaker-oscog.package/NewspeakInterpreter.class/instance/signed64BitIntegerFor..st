primitive support
signed64BitIntegerFor: integerValue
	"Return a Large Integer object for the given integer value"
	| newLargeInteger magnitude largeClass intValue highWord sz |
	<inline: false>
	<var: 'integerValue' type: #sqLong>
	<var: 'magnitude' type: #sqLong>
	<var: 'highWord' type: #usqInt>

	integerValue < 0
		ifTrue: [largeClass := self classLargeNegativeInteger.
				magnitude := 0 - integerValue]
		ifFalse: [largeClass := self classLargePositiveInteger.
				magnitude := integerValue].

	"Make sure to handle the most -ve value correctly.
	 0 - most -ve = most -ve and most -ve - 1 is +ve"
	(magnitude <= 16r7FFFFFFF
	 and: [integerValue >= 0 or: [integerValue - 1 < 0]]) ifTrue:
		[^self signed32BitIntegerFor: integerValue].

	highWord := magnitude >> 32.
	highWord = 0 
		ifTrue:[sz := 4] 
		ifFalse:
			[sz := 5.
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1]].
	newLargeInteger := self instantiateClass: largeClass indexableSize:  sz.
	0 to: sz-1 do: [:i |
		intValue := (magnitude >> (i * 8)) bitAnd: 255.
		self storeByte: i ofObject: newLargeInteger withValue: intValue].
	^newLargeInteger