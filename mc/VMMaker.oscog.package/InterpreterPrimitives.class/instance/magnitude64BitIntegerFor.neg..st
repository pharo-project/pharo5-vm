primitive support
magnitude64BitIntegerFor: magnitude neg: isNegative
	"Return a Large Integer object for the given integer magnitude and sign"
	| newLargeInteger largeClass highWord sz isSmall smallVal |
	<var: 'magnitude' type: #usqLong>
	<var: 'highWord' type: #usqInt>

	isSmall := isNegative
				ifTrue: [magnitude <= (objectMemory maxSmallInteger + 1)]
				ifFalse: [magnitude <= objectMemory maxSmallInteger].
	isSmall ifTrue:
		[smallVal := self cCoerceSimple: magnitude to: #sqInt.
		 isNegative ifTrue: [smallVal := 0 - smallVal].
		 ^objectMemory integerObjectOf: smallVal].

	largeClass := isNegative
					ifTrue: [objectMemory classLargeNegativeInteger]
					ifFalse: [objectMemory classLargePositiveInteger].
	objectMemory wordSize = 8
		ifTrue: [sz := 8]
		ifFalse:
			[(highWord := magnitude >> 32) = 0
				ifTrue: [sz := 4] 
				ifFalse:
					[sz := 5.
					 (highWord := highWord >> 8) = 0 ifFalse:
						[sz := sz + 1.
						 (highWord := highWord >> 8) = 0 ifFalse:
							[sz := sz + 1.
							 (highWord := highWord >> 8) = 0 ifFalse: [sz := sz + 1]]]]].
	newLargeInteger := objectMemory instantiateClass: largeClass indexableSize:  sz.
	self cppIf: VMBIGENDIAN
		ifTrue:
			[sz > 4 ifTrue:
				[objectMemory
					storeByte: 7 ofObject: newLargeInteger withValue: (magnitude >> 56 bitAnd: 16rFF);
					storeByte: 6 ofObject: newLargeInteger withValue: (magnitude >> 48 bitAnd: 16rFF);
					storeByte: 5 ofObject: newLargeInteger withValue: (magnitude >> 40 bitAnd: 16rFF);
					storeByte: 4 ofObject: newLargeInteger withValue: (magnitude >> 32 bitAnd: 16rFF)].
			objectMemory
				storeByte: 3 ofObject: newLargeInteger withValue: (magnitude >> 24 bitAnd: 16rFF);
				storeByte: 2 ofObject: newLargeInteger withValue: (magnitude >> 16 bitAnd: 16rFF);
				storeByte: 1 ofObject: newLargeInteger withValue: (magnitude >>   8 bitAnd: 16rFF);
				storeByte: 0 ofObject: newLargeInteger withValue: (magnitude ">> 0" bitAnd: 16rFF)]
		ifFalse:
			[sz > 4 ifTrue:
				[objectMemory storeLong32: 1 ofObject: newLargeInteger withValue: magnitude >> 32].
			objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: magnitude].

	^newLargeInteger