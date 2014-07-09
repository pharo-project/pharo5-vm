instantiation
instantiateClass: classObj indexableSize: nElements
	<var: #nElements type: #usqInt>
	| instSpec classFormat numSlots classIndex newObj fillValue |
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	fillValue := 0.
	instSpec caseOf: {
		[self arrayFormat]	->
			[nElements > self maxSlotsForAlloc ifTrue:
				[^nil].
			 numSlots := nElements.
			 fillValue := nilObj].
		[self indexablePointersFormat]	->
			[nElements > (self maxSlotsForAlloc - (self fixedFieldsOfClassFormat: classFormat)) ifTrue:
				[^nil].
			 numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self weakArrayFormat]	->
			[nElements > (self maxSlotsForAlloc - (self fixedFieldsOfClassFormat: classFormat)) ifTrue:
				[^nil].
			 numSlots := (self fixedFieldsOfClassFormat: classFormat) + nElements.
			 fillValue := nilObj].
		[self sixtyFourBitIndexableFormat]	->
			[nElements > (self maxSlotsForAlloc / 2) ifTrue:
				[^nil].
			 numSlots := nElements * 2].
		[self firstLongFormat]	->
			[nElements > self maxSlotsForAlloc ifTrue:
				[^nil].
			 numSlots := nElements].
		[self firstShortFormat]	->
			[numSlots := nElements + 1 // 2.
			 numSlots > self maxSlotsForAlloc ifTrue:
				[^nil].
			 instSpec := instSpec + (nElements bitAnd: 1)].
		[self firstByteFormat]	->
			[numSlots := nElements + 3 // 4.
			 numSlots > self maxSlotsForAlloc ifTrue:
				[^nil].
			 instSpec := instSpec + (4 - nElements bitAnd: 3)].
		[self firstCompiledMethodFormat]	->
			[numSlots := nElements + 3 // 4.
			 numSlots > self maxSlotsForAlloc ifTrue:
				[^nil].
			 instSpec := instSpec + (4 - nElements bitAnd: 3)] }
		otherwise: ["some Squeak images include funky fixed subclasses of abstract variable
					 superclasses. e.g. DirectoryEntry as a subclass of ArrayedCollection.
					 Allow fixed classes to be instantiated here iff nElements = 0."
					 (nElements ~= 0 or: [instSpec > self lastPointerFormat]) ifTrue:
						[^nil].
					 numSlots := self fixedFieldsOfClassFormat: classFormat]. "non-indexable"
	classIndex := self ensureBehaviorHash: classObj.
	classIndex < 0 ifTrue:
		[coInterpreter primitiveFailFor: classIndex negated.
		 ^nil].
	numSlots > self maxSlotsForNewSpaceAlloc
		ifTrue: [newObj := self allocateSlotsInOldSpace: numSlots format: instSpec classIndex: classIndex]
		ifFalse: [newObj := self allocateSlots: numSlots format: instSpec classIndex: classIndex].
	newObj ifNotNil:
		[self fillObj: newObj numSlots: numSlots with: fillValue].
	^newObj