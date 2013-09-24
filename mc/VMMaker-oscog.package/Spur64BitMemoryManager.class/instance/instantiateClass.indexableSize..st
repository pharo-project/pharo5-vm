allocation
instantiateClass: classObj indexableSize: nElements
	| instSpec classFormat numSlots classIndex newObj fillValue |
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	fillValue := 0.
	instSpec caseOf: {
		[self arrayFormat]	->
			[numSlots := nElements.
			 fillValue := nilObj].
		[self indexablePointersFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self weakArrayFormat]	->
			[numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self sixtyFourBitIndexableFormat]	->
			[numSlots := nElements].
		[self firstLongFormat]	->
			[numSlots := nElements + 1 // 2.
			 instSpec := instSpec + (nElements bitAnd: 1)].
		[self firstShortFormat]	->
			[numSlots := nElements + 3 // 4.
			 instSpec := instSpec + (4 - nElements bitAnd: 3)].
		[self firstByteFormat]	->
			[numSlots := nElements + 7 // 8.
			 instSpec := instSpec + (8 - nElements bitAnd: 7)].
		[self firstCompiledMethodFormat]	->
			[numSlots := nElements + 7 // 8.
			 instSpec := instSpec + (8 - nElements bitAnd: 7)] }
		otherwise: [^nil]. "non-indexable"
	classIndex := self ensureBehaviorHash: classObj.
	classIndex < 0 ifTrue:
		[coInterpreter primitiveFailFor: classIndex negated.
		 ^nil].
	newObj := self allocateSlots: numSlots format: instSpec classIndex: classIndex.
	newObj ifNotNil:
		[self fillObj: newObj numSlots: numSlots with: fillValue].
	^newObj