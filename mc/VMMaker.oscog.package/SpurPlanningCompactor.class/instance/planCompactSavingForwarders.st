compaction
planCompactSavingForwarders
	"Sweep the heap from firstFreeObject forwarding marked objects to where they
	 can be moved to, saving their forwarding pointer in savedFirstFieldsSpace.
	 Continue until either the end of the heap is reached or savedFirstFieldsSpace is full.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 Note that this method is potentially recursive. If skipping a run of pinned objects
	 causes the the algorithm to encounter another run of immobile objects it will
	 recurse via continuePlanCompactSavingForwardersFrom:.

	 This enumeration matches that in updatePointersInMobileObjects and copyAndUnmarkMobileObjects."

	| toFinger top previousPin |
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace top.
	self deny: (manager isMarked: firstFreeObject).
	manager allOldSpaceEntitiesFrom: firstMobileObject do:
		[:o|
		 self assert: (previousPin isNil or: [toFinger < previousPin]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[previousPin ifNotNil:
						[self assert: previousPin > toFinger.
						 ((manager isSegmentBridge: previousPin)
						  and: [manager isSegmentBridge: o]) ifTrue:
							[self halt: 'empty segment']].
					 previousPin := o]
				ifFalse:
					[| availableSpace bytes next |
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[savedFirstFieldsSpace top: top.
						 ^false].
					 [previousPin notNil
					  and: [availableSpace := (manager startOfObject: previousPin) - toFinger.
							bytes := manager bytesInObject: o.
							bytes ~= availableSpace
							 and: [bytes + (2 * manager allocationUnit) < availableSpace]]] whileTrue:
						["The object does not fit in the space between toFinger and previousPin.
						  Move toFinger beyond previousPin and update previousPin appropriately."
						 toFinger := manager addressAfter: previousPin.
						 next := manager objectStartingAt: toFinger.
						 next >= o ifTrue:
							[savedFirstFieldsSpace top: top.
							 ^self continuePlanCompactSavingForwardersFrom: next].
						 previousPin := (manager isPinned: next) ifTrue: [next]].
					 lastMobileObject := o.
					 manager
						longAt: top put: (manager fetchPointer: 0 ofObject: o);
					 	storePointerUnchecked: 0 "Don't use forward:to:; we dont want to alter the object in any way other than by setting the forwarding pointer"
							ofObject: o
								withValue: ((manager hasOverflowHeader: o)
											ifTrue: [toFinger + manager baseHeaderSize]
											ifFalse: [toFinger]).
					 toFinger := toFinger + (manager bytesInObject: o)]]].
	savedFirstFieldsSpace top: top.
	^true