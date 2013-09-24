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
			[numSlots := nElements * 2].
		[self firstLongFormat]	->
			[numSlots := nElements].
		[self firstShortFormat]	->
			[numSlots := nElements + 1 // 2.
			 instSpec := instSpec + (nElements bitAnd: 1)].
		[self firstByteFormat]	->
			[numSlots := nElements + 3 // 4.
			 instSpec := instSpec + (4 - nElements bitAnd: 3)].
		[self firstCompiledMethodFormat]	->
			[numSlots := nElements + 3 // 4.
			 instSpec := instSpec + (4 - nElements bitAnd: 3)] }
		otherwise: [^nil]. "non-indexable"
	classIndex := self ensureBehaviorHash: classObj.
	classIndex < 0 ifTrue:
		[coInterpreter primitiveFailFor: classIndex negated.
		 ^nil].
	newObj := self allocateSlots: numSlots format: instSpec classIndex: classIndex.
	newObj ifNotNil:
		[self fillObj: newObj numSlots: numSlots with: fillValue].
	^newObj