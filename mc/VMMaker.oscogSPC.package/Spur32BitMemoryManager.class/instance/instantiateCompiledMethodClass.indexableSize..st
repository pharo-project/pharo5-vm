instantiation
instantiateCompiledMethodClass: classObj indexableSize: nElements
	<var: #nElements type: #usqInt>
	"Allocate an instance of a CompiledMethod class."
	<inline: true>
	| instSpec classFormat numSlots classIndex newObj |
	classFormat := self formatOfClass: classObj.
	instSpec := self instSpecOfClassFormat: classFormat.
	instSpec ~= self firstCompiledMethodFormat ifTrue:
		[^nil].
	numSlots := nElements + 3 // 4.
	instSpec := instSpec + (4 - nElements bitAnd: 3).
	classIndex := self ensureBehaviorHash: classObj.
	classIndex < 0 ifTrue:
		[coInterpreter primitiveFailFor: classIndex negated.
		 ^nil].
	numSlots > self maxSlotsForNewSpaceAlloc
		ifTrue:
			[numSlots > self maxSlotsForAlloc ifTrue:
				[^nil].
			 newObj := self allocateSlotsInOldSpace: numSlots format: instSpec classIndex: classIndex]
		ifFalse:
			[newObj := self allocateSlots: numSlots format: instSpec classIndex: classIndex].
	newObj ifNotNil:
		[self fillObj: newObj numSlots: numSlots with: 0].
	^newObj