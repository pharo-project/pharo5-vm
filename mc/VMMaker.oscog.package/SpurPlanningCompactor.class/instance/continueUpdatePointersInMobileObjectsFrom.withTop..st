compaction
continueUpdatePointersInMobileObjectsFrom: anUnpinnedEntity withTop: initialTop
	"updatePointersInMobileObjects has encountered a run of pinned objects around which
	 planCompactSavingForwarders cannot compact, but savedFirstFieldsSpace is still not full.
	 Continue the pass with a new firstFreeObject , resetting it before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	<var: 'initialTop' type: #usqInt>
	| result top savedFirstFreeObject savedFirstMobileObject nextFreeObject |
	<var: 'top' type: #usqInt>
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	top := initialTop.
	"Update the run of immobile objects to match the enumeration in continuePlanCompactSavingForwardersFrom:toFinger:."
	manager allOldSpaceEntitiesFrom: anUnpinnedEntity to: firstMobileObject do:
		[:o|
		 ((self oop: o isLessThan: firstMobileObject)
		  and: [manager isMarked: o]) ifTrue:
			[(manager isPinned: o)
				ifTrue: [self updatePointersIn: o]
				ifFalse:
					[(top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[^false].
					 self updatePointersIn: o savedFirstFieldPointer: top]]].
	firstMobileObject := savedFirstMobileObject.
	nextFreeObject ifNil:
		[^true].
	savedFirstFreeObject := firstFreeObject.
	firstFreeObject := nextFreeObject.
	result := self updatePointersInMobileObjectsWithTop: top.
	firstFreeObject := savedFirstFreeObject.
	^result