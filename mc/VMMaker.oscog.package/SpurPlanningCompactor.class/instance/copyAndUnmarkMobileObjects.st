compaction
copyAndUnmarkMobileObjects
	"Sweep the mobile portion of the heap, moving objects to their eventual locations, and clearing their marked bits.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 This enumeration matches those in planCompactSavingForwarders and updatePointersInMobileObjects."
	<inline: #never>
	| toFinger top previousPin |
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	self deny: (manager isMarked: firstFreeObject).
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start.
	manager allOldSpaceEntitiesForCompactingFrom: firstFreeObject do:
		[:o :n|
		 self check: o.
		 self assert: (previousPin
						ifNil: [toFinger <= (manager startOfObject: o)]
						ifNotNil: [(manager isMarked: previousPin) and: [toFinger <= (manager startOfObject: previousPin)]]).
		 self assert: (savedFirstFieldsSpaceWasAllocated
					or: [savedFirstFieldsSpace limit <= manager firstObject asUnsignedInteger
					or: [toFinger < top]]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[(manager isSegmentBridge: o) ifFalse:
						[manager setIsMarkedOf: o to: false.
						 manager segmentManager notePinned: o].
					 previousPin ifNotNil:
						[| limit |
						 limit := manager startOfObject: previousPin.
						 manager addFreeChunkWithBytes: limit - toFinger at: toFinger.
						 toFinger := manager addressAfter: previousPin.
						 self assert: toFinger <= (manager startOfObject: o)].
					 previousPin := o]
				ifFalse:
					[| availableSpace bytes next |
					 [previousPin notNil
					  and: [availableSpace := (manager startOfObject: previousPin) - toFinger.
							bytes := manager bytesInObject: o.
							bytes ~= availableSpace
							and: [bytes + (2 * manager allocationUnit) > availableSpace]]] whileTrue:
						["The object does not fit in the space between toFinger and previousPin.
						  Move toFinger beyond previousPin and update previousPin appropriately."
						 availableSpace > 0 ifTrue:
							[manager addFreeChunkWithBytes: availableSpace at: toFinger].
						 toFinger := manager addressAfter: previousPin.
						 next := manager objectStartingAt: toFinger.
						 previousPin := ((manager isMarked: next) and: [manager isPinned: next]) ifTrue: [next]].
					 toFinger := self copyAndUnmarkObject: o to: toFinger firstField: (manager longAt: top).
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[| done |
						 self assert: savedFirstFieldsSpace top = (top - manager bytesPerOop).
						 done := self noMobileObjectsAfter: n.
						 done
							ifTrue: [self freeAllUnpinnedObjectsFromObject: (previousPin ifNil: [n]) toFinger: toFinger]
							ifFalse: [self freeFrom: toFinger upTo: (manager startOfObject: n) previousPin: previousPin].
						^done]]]].
	self freeFrom: toFinger upTo: manager endOfMemory previousPin: previousPin.
	^true