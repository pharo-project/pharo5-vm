compaction
planCompactSavingForwarders
	"Sweep the heap from firstFreeObject forwarding marked objects to where they
	 can be moved to, saving their forwarding pointer in savedFirstFieldsSpace.
	 Continue until either the end of the heap is reached or savedFirstFieldsSpace is full.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 Note that this method is potentially recursive. If skipping a run of pinned objects
	 causes the the algorithm to encounter another run of immobile objects it will
	 recurse via continuePlanCompactSavingForwardersFrom:.

	 This enumeration matches those in updatePointersInMobileObjects and copyAndUnmarkMobileObjects."

	| toFinger top previousPin |
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	savedFirstFieldsSpace top < savedFirstFieldsSpace start ifTrue:
		[self logPhase: 'planning...'].
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace top.
	self deny: (manager isMarked: firstFreeObject).
	manager allOldSpaceEntitiesFrom: firstFreeObject do:
		[:o|
		 self check: o.
		 self assert: (previousPin isNil or: [(manager isMarked: previousPin) and: [toFinger <= previousPin]]).
		 self assert: (savedFirstFieldsSpaceWasAllocated
					or: [savedFirstFieldsSpace limit <= manager firstObject asUnsignedInteger
					or: [toFinger < top]]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue: "The empty gaps between two adjacent pinned objects (when not filled below) are freed."
					[previousPin ifNotNil:
						[self assert: (manager startOfObject: previousPin) - toFinger >= (manager allocationUnit * 2).
						 toFinger := manager addressAfter: previousPin.
						 self assert: toFinger <= (manager startOfObject: o)].
					 previousPin := o]
				ifFalse:
					[| availableSpace bytes next |
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[savedFirstFieldsSpace top: top - manager bytesPerOop.
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
						 (self oop: next isGreaterThanOrEqualTo: o) ifTrue:
							[savedFirstFieldsSpace top: top - manager bytesPerOop.
							 ^self continuePlanCompactSavingForwardersFrom: o toFinger: toFinger].
						 previousPin := ((manager isMarked: next) and: [manager isPinned: next]) ifTrue: [next]].
					 toFinger := self forwardMobileObject: o to: toFinger savedFirstFieldPtr: top]]].
	savedFirstFieldsSpace top: top.
	^true