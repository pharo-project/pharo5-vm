compaction
copyAndUnmarkMobileObjects
	"Sweep the mobile portion of the heap, moving objects to their eventual locations, and clearing their marked bits.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
	 This enumeration matches that in planCompactSavingForwarders and updatePointersInMobileObjects."

	| toFinger top previousPin |
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start - manager bytesPerOop.
	self deny: (manager isMarked: firstFreeObject).
	manager allOldSpaceEntitiesForCompactingFrom: firstFreeObject do:
		[:o|
		 self assert: (previousPin isNil or: [toFinger < previousPin]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[(manager isSegmentBridge: o) ifFalse:
						[manager setIsMarkedOf: o to: false.
						 manager segmentManager notePinned: o]. 
					 previousPin ifNotNil:
						[self assert: previousPin > toFinger.
						 ((manager isSegmentBridge: previousPin)
						  and: [manager isSegmentBridge: o]) ifTrue:
							[self halt: 'empty segment']].
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
						 self assert: toFinger < manager endOfMemory.
						 next := manager objectStartingAt: toFinger.
						 next >= o ifTrue:
							[^self continueCopyAndUnmarkMobileObjectsFrom: next].
						 previousPin := (manager isPinned: next) ifTrue: [next]].
					 bytes := self copyAndUnmarkObject: o to: toFinger firstField: (manager longAt: top).
					 toFinger := toFinger + bytes]]].
	self freeFrom: toFinger upTo: manager endOfMemory previousPin: previousPin.
	^true