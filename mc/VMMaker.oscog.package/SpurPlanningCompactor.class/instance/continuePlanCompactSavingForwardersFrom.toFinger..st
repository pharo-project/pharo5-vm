compaction
continuePlanCompactSavingForwardersFrom: anUnpinnedEntity toFinger: initialToFinger
	"planCompactSavingForwarders has encountered a run of pinned objects around which
	 it cannot compact, but savedFirstFieldsSpace is still not full.  Continue the pass with a
	 new firstFreeObject, resetting it before continuing.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed)."
	<var: 'initialToFinger' type: #usqInt>
	| result toFinger savedFirstMobileObject savedFirstFreeObject nextFreeObject |
	<var: 'toFinger' type: #usqInt>
	self assert: (self oop: anUnpinnedEntity isLessThan: manager endOfMemory).
	self deny: (manager isPinned: anUnpinnedEntity).
	toFinger := initialToFinger.
	savedFirstMobileObject := firstMobileObject.
	nextFreeObject := self scanForFirstFreeAndFirstMobileObjectFrom: anUnpinnedEntity.
	"Forward the run of immobile objects since all unpinned objects between firstMobileObject
	 and lastMobileObject must be forwarded.  Return if savedFirstFieldsSpace fills up."
	manager allOldSpaceEntitiesFrom: anUnpinnedEntity to: firstMobileObject do:
		[:o| | newTop |
		 ((self oop: o isLessThan: firstMobileObject)
		  and: [manager isMarked: o]) ifTrue:
			[(manager isPinned: o)
				ifTrue: [self assert: (manager addressAfter: o) <= initialToFinger]
				ifFalse:
					[(newTop := savedFirstFieldsSpace top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[firstMobileObject := savedFirstMobileObject.
						 ^false]].
					 self assert: (manager startOfObject: o) >= toFinger.
					 toFinger := self forwardMobileObject: o to: toFinger savedFirstFieldPtr: newTop.
					 savedFirstFieldsSpace top: newTop]].
	firstMobileObject := savedFirstMobileObject.
	nextFreeObject ifNil:
		[^true].
	self assert: (self oop: nextFreeObject isGreaterThan: lastMobileObject).
	manager allOldSpaceEntitiesFrom: (manager objectAfter: lastMobileObject) to: nextFreeObject do:
		[:o|
		 self deny: ((manager isMarked: o) and: [(manager isPinned: o) not])].
	savedFirstFreeObject := firstFreeObject.
	firstFreeObject := nextFreeObject.
	result := self planCompactSavingForwarders.
	firstFreeObject := savedFirstFreeObject.
	^result