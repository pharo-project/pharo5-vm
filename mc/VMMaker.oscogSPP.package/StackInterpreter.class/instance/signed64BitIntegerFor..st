primitive support
signed64BitIntegerFor: integerValue
	<var: 'integerValue' type: #sqLong>
	"Answer a Large Integer object for the given integer value.  N.B. will *not* cause a GC."
	| newLargeInteger magnitude largeClass highWord sz |
	<inline: false>
	<var: 'magnitude' type: #usqLong>
	<var: 'highWord' type: #usqInt>

	integerValue < 0
		ifTrue:[	integerValue >= objectMemory minSmallInteger ifTrue: [^objectMemory integerObjectOf: integerValue asInteger].
				largeClass := ClassLargeNegativeIntegerCompactIndex.
				magnitude := 0 - (self cCoerceSimple: integerValue to: #usqLong)]
		ifFalse:[	integerValue <= objectMemory maxSmallInteger ifTrue: [^objectMemory integerObjectOf: integerValue asInteger].
				largeClass := ClassLargePositiveIntegerCompactIndex.
				magnitude := integerValue].

	objectMemory wordSize = 8
		ifTrue: [sz := 8]
		ifFalse: [
		 (highWord := magnitude >> 32) = 0 
			ifTrue: [sz := 4] 
			ifFalse:
				[sz := 5.
				 (highWord := highWord >> 8) = 0 ifFalse:
					[sz := sz + 1.
					 (highWord := highWord >> 8) = 0 ifFalse:
						[sz := sz + 1.
						 (highWord := highWord >> 8) = 0 ifFalse:
							[sz := sz + 1]]]]].

	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: largeClass
							format: (objectMemory byteFormatForNumBytes: sz)
							numSlots: sz + 3 // objectMemory bytesPerOop.
	SPURVM
		ifTrue:
			["Memory is eight byte aligned in SPUR, so we are sure to have room for 64bits word whatever allocated sz"
			objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped64IfBigEndian: magnitude)]
		ifFalse:
			[sz > 4
				ifTrue: [objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped64IfBigEndian: magnitude)]
				ifFalse: [objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (objectMemory byteSwapped32IfBigEndian: magnitude)]].
	^newLargeInteger