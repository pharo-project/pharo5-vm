bootstrap image
cloneObjects
	| characterClass characterTable compactClasses oldObj oldClass |
	characterClass := oldHeap classCharacter.
	characterTable := oldHeap characterTable.
	compactClasses := oldHeap splObj: CompactClasses.
	oldObj := oldHeap objectAfter: oldHeap trueObject.
	[oldObj < oldHeap freeStart] whileTrue:
		[oldClass := oldHeap fetchClassOfNonImm: oldObj.
		 (oldObj ~= characterTable
		 and: [oldObj ~= compactClasses
		 and: [oldClass ~= characterClass]]) ifTrue:
			[self clone: oldObj classIndex: (classToIndex at: oldClass)].
		 oldObj := oldHeap objectAfter: oldObj].
	newHeap
		specialObjectsOop: (map at: oldHeap specialObjectsOop);
		lastHash: oldHeap lastHash