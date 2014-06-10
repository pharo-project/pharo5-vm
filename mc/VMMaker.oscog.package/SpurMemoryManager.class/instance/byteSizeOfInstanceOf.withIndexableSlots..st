indexing primitive support
byteSizeOfInstanceOf: classObj withIndexableSlots: nElements
	| instSpec classFormat numSlots |
	<var: 'numSlots' type: #usqInt>
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	instSpec caseOf: {
		[self arrayFormat]	->
			[numSlots := nElements].
		[self indexablePointersFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements].
		[self weakArrayFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements].
		[self sixtyFourBitIndexableFormat]	->
			[numSlots := self bytesPerSlot = 4 ifTrue: [nElements * 2] ifFalse: [nElements]].
		[self firstLongFormat]	->
			[numSlots := self bytesPerSlot = 4 ifTrue: [nElements] ifFalse: [nElements + 1 // 2]].
		[self firstShortFormat]	->
			[numSlots := self bytesPerSlot = 4 ifTrue: [nElements + 1 // 2] ifFalse: [nElements + 3 // 4]].
		[self firstByteFormat]	->
			[numSlots := nElements + (self bytesPerSlot - 1) // self bytesPerSlot].
		[self firstCompiledMethodFormat]	-> "Assume nElements is derived from CompiledMethod>>basicSize."
			[numSlots := nElements + (self bytesPerSlot - 1) // self bytesPerSlot] }
		otherwise: [^PrimErrBadReceiver negated]. "non-indexable"
	numSlots >= (1 << (self bytesPerSlot * 8 - self logBytesPerSlot)) ifTrue:
		[^PrimErrLimitExceeded negated].
	^self objectBytesForSlots: numSlots