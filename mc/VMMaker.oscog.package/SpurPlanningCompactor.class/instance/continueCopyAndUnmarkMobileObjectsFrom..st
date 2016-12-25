compaction
continueCopyAndUnmarkMobileObjectsFrom: anUnpinnedEntity
	"copyAndUnmarkMobileObjects has encountered a run of pinned objects around which
	 it cannot compact, but savedFirstFieldsSpace is still not full.  Continue the pass with new
	 firstFreeObject and firstMobileObject, resetting them before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	| result savedFirstFreeObject savedFirstMobileObject nextFreeObject |
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	savedFirstFreeObject := firstFreeObject.
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	nextFreeObject ifNil:
		[^true].
	firstFreeObject := nextFreeObject.
	result := self copyAndUnmarkMobileObjects.
	firstFreeObject := savedFirstFreeObject.
	firstMobileObject := savedFirstMobileObject.
	^result