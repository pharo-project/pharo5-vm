primitive support
magnitude64BitIntegerFor: magnitude neg: isNegative
	"Return a Large Integer object for the given integer magnitude and sign"
	| newLargeInteger largeClass intValue highWord sz isSmall smallVal |
	<var: 'magnitude' type: #usqLong>
	<var: 'highWord' type: #usqInt>

	isSmall := isNegative
				ifTrue: [magnitude <= 16r40000000]
				ifFalse: [magnitude < 16r40000000].
	isSmall ifTrue:
		[smallVal := self cCoerceSimple: magnitude to: #sqInt.
		isNegative	ifTrue: [smallVal := 0 - smallVal].
		^objectMemory integerObjectOf: smallVal].
	largeClass := isNegative
					ifTrue: [objectMemory classLargeNegativeInteger]
					ifFalse: [objectMemory classLargePositiveInteger].
	highWord := magnitude >> 32.
	highWord = 0 
		ifTrue: [sz := 4] 
		ifFalse:
			[sz := 5.
			(highWord := highWord >> 8) = 0 ifFalse: [sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse: [sz := sz + 1].
			(highWord := highWord >> 8) = 0 ifFalse: [sz := sz + 1]].
	newLargeInteger := objectMemory instantiateClass: largeClass indexableSize:  sz.
	0 to: sz-1 do: [:i |
		intValue := (magnitude >> (i * 8)) bitAnd: 255.
		objectMemory storeByte: i ofObject: newLargeInteger withValue: intValue].
	^newLargeInteger