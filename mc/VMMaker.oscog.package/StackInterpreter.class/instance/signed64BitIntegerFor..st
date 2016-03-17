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
			[sz > 4
				ifTrue: [objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: magnitude]
				ifFalse: [objectMemory storeLong32: 0 ofObject: newLargeInteger withValue: (self cCode: [magnitude] inSmalltalk: [magnitude bitAnd: 16rFFFFFFFF])]].
	^newLargeInteger