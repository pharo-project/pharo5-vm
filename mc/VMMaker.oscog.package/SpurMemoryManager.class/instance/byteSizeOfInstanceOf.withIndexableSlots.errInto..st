indexing primitive support
byteSizeOfInstanceOf: classObj withIndexableSlots: nElements errInto: errorBlock
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
			[numSlots := self bytesPerOop = 4 ifTrue: [nElements * 2] ifFalse: [nElements]].
		[self firstLongFormat]	->
			[numSlots := self bytesPerOop = 4 ifTrue: [nElements] ifFalse: [nElements + 1 // 2]].
		[self firstShortFormat]	->
			[numSlots := self bytesPerOop = 4 ifTrue: [nElements + 1 // 2] ifFalse: [nElements + 3 // 4]].
		[self firstByteFormat]	->
			[numSlots := nElements + (self bytesPerOop - 1) // self bytesPerOop].
		[self firstCompiledMethodFormat]	-> "Assume nElements is derived from CompiledMethod>>basicSize."
			[numSlots := nElements + (self bytesPerOop - 1) // self bytesPerOop] }
		otherwise: [^errorBlock value: PrimErrBadReceiver negated]. "non-indexable"
	numSlots >= (1 asUnsignedInteger << (self bytesPerOop * 8 - self logBytesPerOop)) ifTrue:
		[^errorBlock value: (nElements < 0 ifTrue: [PrimErrBadArgument] ifFalse: [PrimErrLimitExceeded])].
	^self objectBytesForSlots: numSlots