debug support
indexOf: anElement in: anObject
	<api>
	| fmt numSlots |
	fmt := self formatOf: anObject.

	fmt <= self lastPointerFormat ifTrue:
		[numSlots := self numSlotsOf: anObject.
		 0 to: numSlots do:
			[:i| anElement = (self fetchPointer: i ofMaybeForwardedObject: anObject) ifTrue: [^i]].
		-1].

	fmt >= self firstByteFormat ifTrue:
		[fmt >= self firstCompiledMethodFormat ifTrue:
			[^self primitiveFailFor: PrimErrUnsupported].
		 numSlots := self numBytesOfBytes: anObject.
		 0 to: numSlots do:
			[:i| (self fetchByte: i ofObject: anObject) ifTrue: [^i]].
		-1].

	fmt >= self firstShortFormat ifTrue:
		[numSlots := self num16BitUnitsOf: anObject.
		 0 to: numSlots do:
			[:i| anElement = (self fetchUnsignedShort16: i ofObject: anObject) ifTrue: [^i]].
		-1].

	fmt = self sixtyFourBitIndexableFormat ifTrue:
		[numSlots := self num64BitUnitsOf: anObject.
		 0 to: numSlots do:
			[:i| anElement = (self fetchLong64: i ofObject: anObject) ifTrue: [^i]].
		-1].

	fmt >= self firstLongFormat ifTrue:
		[numSlots := self num32BitUnitsOf: anObject.
		 0 to: numSlots do:
			[:i| anElement = (self fetchLong32: i ofObject: anObject) ifTrue: [^i]].
		-1].

	^-1