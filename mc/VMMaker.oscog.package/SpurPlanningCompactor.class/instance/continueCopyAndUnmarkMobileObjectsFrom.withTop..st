compaction
continueCopyAndUnmarkMobileObjectsFrom: anUnpinnedEntity withTop: initialTop
	"copyAndUnmarkMobileObjects has encountered a run of pinned objects around which
	 it cannot compact, but savedFirstFieldsSpace is still not full.  Continue the pass with a
	 new firstFreeObject, resetting it before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	<var: 'initialTop' type: #usqInt>
	| result top savedFirstFreeObject savedFirstMobileObject nextFreeObject |
	<var: 'top' type: #usqInt>
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	top := initialTop.
	"Copy and unmark the run of immobile objects to match the enumeration in continuePlanCompactSavingForwardersFrom:toFinger:."
	manager allOldSpaceEntitiesFrom: anUnpinnedEntity to: firstMobileObject do:
		[:o|
		 ((self oop: o isLessThan: firstMobileObject)
		  and: [manager isMarked: o]) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[(manager isSegmentBridge: o) ifFalse:
						[manager setIsMarkedOf: o to: false.
						 manager segmentManager notePinned: o]]
				ifFalse:
					[(top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[^false].
					 self assert: o = (manager fetchPointer: 0 ofObject: o).
					 manager
						setIsMarkedOf: o to: false;
						storePointerUnchecked: 0 ofObject: o withValue: (manager longAt: top)]]].
	firstMobileObject := savedFirstMobileObject.
	nextFreeObject ifNil:
		[^true].
	savedFirstFreeObject := firstFreeObject.
	firstFreeObject := nextFreeObject.
	result := self copyAndUnmarkMobileObjectsWithTop: top.
	firstFreeObject := savedFirstFreeObject.
	^result