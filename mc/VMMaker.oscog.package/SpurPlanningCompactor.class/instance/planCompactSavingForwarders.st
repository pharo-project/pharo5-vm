compaction
planCompactSavingForwarders
	"Sweep the heap from firstFreeObject forwarding marked objects to where they
	 can be moved to, saving their forwarding pointer in savedFirstFieldsSpace.
	 Continue until either the end of the heap is reached or savedFirstFieldsSpace is full.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 This enumeration matches those in updatePointersInMobileObjects and copyAndUnmarkMobileObjects."
	<inline: #never>
	| toFinger top previousPin |
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	savedFirstFieldsSpace top < savedFirstFieldsSpace start ifTrue:
		[self logPhase: 'planning...'].
	self deny: (manager isMarked: firstFreeObject).
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start.
	manager allOldSpaceEntitiesFrom: firstFreeObject do:
		[:o|
		 self check: o.
		 self assert: (previousPin
						ifNil: [toFinger <= (manager startOfObject: o)]
						ifNotNil: [(manager isMarked: previousPin) and: [toFinger <= (manager startOfObject: previousPin)]]).
		 self assert: (savedFirstFieldsSpaceNotInOldSpace or: [toFinger < top]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue: "The empty gaps between two adjacent pinned objects (when not filled below) are freed."
					[[previousPin notNil and: [previousPin ~= o]] whileTrue:
						[self assert: ((manager startOfObject: previousPin) - toFinger >= (manager allocationUnit * 2)
									or: [(manager startOfObject: previousPin) = toFinger]).
						 toFinger := manager addressAfter: previousPin.
						 previousPin := manager objectStartingAt: toFinger.
						 ((manager isPinned: previousPin) and: [manager isMarked: previousPin])
							ifTrue: [toFinger := manager addressAfter: previousPin]
							ifFalse: [previousPin := nil]].
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
						 toFinger := manager addressAfter: previousPin.
						 next := manager objectStartingAt: toFinger.
						 previousPin := ((manager isMarked: next) and: [manager isPinned: next]) ifTrue: [next]].
					 toFinger := self forwardMobileObject: o to: toFinger savedFirstFieldPtr: top.
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[savedFirstFieldsSpace top: top - manager bytesPerOop.
						 ^self noMobileObjectsAfter: o]]]].
	savedFirstFieldsSpace top: top - manager bytesPerOop.
	^true