bootstrap image
cloneObjects
	| specialObjectsArray characterClass characterTable compactClasses oldObj oldClass |
	specialObjectsArray := oldHeap specialObjectsOop.
	characterClass := oldHeap classCharacter.
	characterTable := oldHeap characterTable.
	compactClasses := oldHeap splObj: CompactClasses.
	self clone: specialObjectsArray
		classIndex: (classToIndex at: (oldHeap fetchClassOfNonImm: specialObjectsArray)).
	oldObj := oldHeap objectAfter: oldHeap trueObject.
	[oldObj < oldHeap freeStart] whileTrue:
		[oldClass := oldHeap fetchClassOfNonImm: oldObj.
		 (oldObj ~= characterTable
		 and: [oldObj ~= specialObjectsArray
		 and: [oldObj ~= compactClasses
		 and: [oldClass ~= characterClass]]]) ifTrue:
			[self clone: oldObj classIndex: (classToIndex at: oldClass)].
		 oldObj := oldHeap objectAfter: oldObj].
	newHeap
		specialObjectsOop: (map at: oldHeap specialObjectsOop);
		lastHash: oldHeap lastHash