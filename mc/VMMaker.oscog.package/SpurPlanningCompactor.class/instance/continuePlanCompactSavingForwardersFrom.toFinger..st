compaction
continuePlanCompactSavingForwardersFrom: anUnpinnedEntity toFinger: initialToFinger
	"planCompactSavingForwarders has encountered a run of pinned objects around which
	 it cannot compact, but savedFirstFieldsSpace is still not full.  Continue the pass with a
	 new firstFreeObject, resetting it before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	| result toFinger savedFirstMobileObject nextFreeObject |
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	toFinger := initialToFinger.
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	manager allOldSpaceEntitiesFrom: anUnpinnedEntity to: firstMobileObject do:
		[:o| | newTop |
		 (o < firstMobileObject
		  and: [manager isMarked: o]) ifTrue:
			[(manager isPinned: o)
				ifTrue: [self assert: (manager addressAfter: o) <= initialToFinger]
				ifFalse:
					[(newTop := savedFirstFieldsSpace top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[firstMobileObject := savedFirstMobileObject.
						 ^false]].
					 self assert: (manager startOfObject: o) >= toFinger.
					 manager
						longAt: newTop
							put: (manager fetchPointer: 0 ofObject: o);
						storePointerUnchecked: 0
							ofObject: o
								withValue: ((manager hasOverflowHeader: o)
												ifTrue: [toFinger + manager baseHeaderSize]
												ifFalse: [toFinger]).
					 savedFirstFieldsSpace top: newTop.
					 toFinger := toFinger + (manager bytesInObject: o).
					 lastMobileObject := o]].
	firstMobileObject := savedFirstMobileObject.
	nextFreeObject ifNil:
		[^true].
	self assert: nextFreeObject > lastMobileObject.
	manager allOldSpaceEntitiesFrom: (manager objectAfter: lastMobileObject) to: nextFreeObject do:
		[:o|
		 self deny: ((manager isMarked: o) and: [(manager isPinned: o) not])].
	firstFreeObject := nextFreeObject.
	result := self planCompactSavingForwarders.
	^result