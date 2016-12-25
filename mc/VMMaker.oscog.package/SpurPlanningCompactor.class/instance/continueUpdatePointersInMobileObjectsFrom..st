compaction
continueUpdatePointersInMobileObjectsFrom: anUnpinnedEntity
	"updatePointersInMobileObjects has encountered a run of pinned objects around which
	 planCompactSavingForwarders cannot compact, but savedFirstFieldsSpace is still not full.
	 Continue the pass with new firstFreeObject and firstMobileObject, resetting them before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	| result savedFirstFreeObject savedFirstMobileObject nextFreeObject |
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	savedFirstFreeObject := firstFreeObject.
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	nextFreeObject ifNil:
		[^true].
	result := self updatePointersInMobileObjects.
	firstFreeObject := savedFirstFreeObject.
	firstMobileObject := savedFirstMobileObject.
	^result