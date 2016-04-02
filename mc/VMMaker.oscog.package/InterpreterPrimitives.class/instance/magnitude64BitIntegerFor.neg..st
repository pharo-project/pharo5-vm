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
			[sz > 4
				ifTrue: [objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: magnitude byteSwap64]
				ifFalse: [objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (magnitude byteSwap32)]]
		ifFalse:
			[sz > 4
				ifTrue: [objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: magnitude]
				ifFalse: [objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (self cCode: [magnitude] inSmalltalk: [magnitude bitAnd: 16rFFFFFFFF])]].

	^newLargeInteger