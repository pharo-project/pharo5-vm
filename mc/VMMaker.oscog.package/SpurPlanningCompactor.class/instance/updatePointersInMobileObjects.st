compaction
updatePointersInMobileObjects
	"Sweep the mobile portion of the heap, updating all references to objects to their eventual locations.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 This enumeration matches that in planCompactSavingForwarders and copyAndUnmarkMobileObjects."
	| toFinger top previousPin |
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	self deny: (manager isMarked: firstFreeObject).
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start.
	manager allOldSpaceEntitiesFrom: firstFreeObject do:
		[:o|
		 self check: o.
		 self assert: (previousPin
						ifNil: [toFinger <= (manager startOfObject: o)]
						ifNotNil: [(manager isMarked: previousPin) and: [toFinger <= (manager startOfObject: previousPin)]]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue: "The empty gaps between two adjacent pinned objects (when not filled below) are freed."
					[self updatePointersIn: o.
					 previousPin ifNotNil:
						[toFinger := manager addressAfter: previousPin].
					 previousPin := o]
				ifFalse:
					[| availableSpace bytes next |
					 [previousPin notNil
					  and: [availableSpace := (manager startOfObject: previousPin) - toFinger.
							bytes := manager bytesInObject: o.
							bytes ~= availableSpace
							 and: [bytes + (2 * manager allocationUnit) < availableSpace]]] whileTrue:
						["The object does not fit in the space between toFinger and previousPin.
						  Move toFinger beyond previousPin and update previousPin appropriately."
						 toFinger := manager addressAfter: previousPin.
						 next := manager objectStartingAt: toFinger.
						 previousPin := ((manager isMarked: next) and: [manager isPinned: next]) ifTrue: [next]].
					 self updatePointersIn: o savedFirstFieldPointer: top.
					 toFinger := toFinger + (manager bytesInObject: o).
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[self assert: savedFirstFieldsSpace top = (top - manager bytesPerOop).
						 ^self noMobileObjectsAfter: o]]]].
	self assert: savedFirstFieldsSpace top = (top - manager bytesPerOop).
	^true