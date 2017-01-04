compaction
copyAndUnmarkMobileObjectsWithTop: initialTop
	"Sweep the mobile portion of the heap, moving objects to their eventual locations, and clearing their marked bits.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
	 This enumeration matches those in planCompactSavingForwarders and updatePointersInMobileObjects."
	<var: 'initialTop' type: #usqInt>
	| toFinger top previousPin |
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	toFinger := manager startOfObject: firstFreeObject.
	top := initialTop.
	self deny: (manager isMarked: firstFreeObject).
	manager allOldSpaceEntitiesForCompactingFrom: firstFreeObject do:
		[:o|
		 self check: o.
		 self assert: (previousPin isNil or: [(manager isMarked: previousPin) and: [toFinger <= previousPin]]).
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
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[self freeFrom: toFinger upTo: (manager startOfObject: o) previousPin: previousPin.
						 ^false].
					 [previousPin notNil
					  and: [availableSpace := (manager startOfObject: previousPin) - toFinger.
							bytes := manager bytesInObject: o.
							bytes ~= availableSpace
							 and: [bytes + (2 * manager allocationUnit) < availableSpace]]] whileTrue:
						["The object does not fit in the space between toFinger and previousPin.
						  Move toFinger beyond previousPin and update previousPin appropriately."
						 availableSpace > 0 ifTrue:
							[manager addFreeChunkWithBytes: availableSpace at: toFinger].
						 toFinger := manager addressAfter: previousPin.
						 next := manager objectStartingAt: toFinger.
						 (self oop: next isGreaterThanOrEqualTo: o) ifTrue:
							[^self continueCopyAndUnmarkMobileObjectsFrom: o withTop: top - manager bytesPerOop].
						 previousPin := ((manager isMarked: next) and: [manager isPinned: next]) ifTrue: [next]].
					 toFinger := self copyAndUnmarkObject: o to: toFinger firstField: (manager longAt: top)]]].
	self freeFrom: toFinger upTo: manager endOfMemory previousPin: previousPin.
	^true