compaction
updatePointersInMobileObjects
	"Sweep the mobile portion of the heap, updating all references to objects to their eventual locations.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
	 This enumeration matches that in planCompactSavingForwarders and copyAndUnmarkMobileObjects."

	| toFinger top previousPin |
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start - manager bytesPerOop.
	self deny: (manager isMarked: firstFreeObject).
	manager allOldSpaceEntitiesFrom: firstFreeObject do:
		[:o|
		 self assert: (previousPin isNil or: [toFinger < previousPin]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[self updatePointersIn: o startingAt: 0 savedFirstFieldPointer: nil.
					 previousPin ifNotNil:
						[self assert: previousPin > toFinger.
						 ((manager isSegmentBridge: previousPin)
						  and: [manager isSegmentBridge: o]) ifTrue:
							[self halt: 'empty segment']].
					 previousPin := o]
				ifFalse:
					[| availableSpace bytes next |
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[^false].
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
							[^self continueUpdatePointersInMobileObjectsFrom: next].
						 previousPin := (manager isPinned: next) ifTrue: [next]].
					 ((manager formatOf: o) <= manager lastPointerFormat
					  and: [(manager numSlotsOf: o) > 0]) ifTrue:
						[| oop fwd |
						 "Relocate the saved first field; Note that CompiledMethods can be excluded since their
						  first field is either a SmallInteger or a reference to a CogMethod outside of oldSpace."
						 oop := manager longAt: top.
						 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
							[self assert: (manager isMarked: oop).
							 fwd := manager fetchPointer: 0 ofObject: oop.
							 self assert: (self isPostMobile: fwd).
							 manager longAt: top put: fwd]].
					 self updatePointersIn: o startingAt: 1 savedFirstFieldPointer: top.
					 toFinger := toFinger + (manager bytesInObject: o)]]].
	^true