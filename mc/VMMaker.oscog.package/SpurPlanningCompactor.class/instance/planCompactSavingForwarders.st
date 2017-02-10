compaction
planCompactSavingForwarders
	"Sweep the heap from firstFreeObject forwarding marked objects to where they
	 can be moved to, saving their forwarding pointer in savedFirstFieldsSpace.
	 Continue until either the end of the heap is reached or savedFirstFieldsSpace is full.
	 Answer if the end of the heap was reached (savedFirstFieldsSpace has not overflowed).

	 The enumerations in planCompactSavingForwarders, updatePointersInMobileObjects and copyAndUnmarkMobileObjects
	 match.  We could implement them as a single enumeration method taking several block arguments, but arguably that
	 would make understanding an already tricky algorithm more difficult.  Instead we tolerate the duplication and encourage
	 the reader to diff the three methods to see where they diverge (e.g. via Cmd-shift-C)."
	<inline: #never>
	| toFinger top previousPin startOfPreviousPin |
	<var: 'o' type: #usqInt>
	<var: 'top' type: #usqInt>
	<var: 'toFinger' type: #usqInt>
	<var: 'previousPin' type: #usqInt>
	<var: 'startOfPreviousPin' type: #usqInt>
	savedFirstFieldsSpace top < savedFirstFieldsSpace start ifTrue:
		[self logPhase: 'planning...'].
	self deny: (manager isMarked: firstFreeObject).
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start.
	startOfPreviousPin := 0.
	manager allOldSpaceEntitiesFrom: firstFreeObject do:
		[:o|
		 self check: o.
		 self assert: (previousPin
						ifNil: [toFinger <= (manager startOfObject: o)]
						ifNotNil: [(manager isMarked: previousPin) and: [toFinger <= startOfPreviousPin]]).
		 self assert: (savedFirstFieldsSpaceNotInOldSpace or: [toFinger < top]).
		 (manager isMarked: o) ifTrue:
			[(manager isPinned: o)
				ifTrue:
					[previousPin ifNil:
						[previousPin := o. startOfPreviousPin := manager startOfObject: o]]
				ifFalse:
					[| availableSpace bytes |
					 bytes := manager bytesInObject: o.
					 [toFinger <= startOfPreviousPin
					  and: [bytes ~= (availableSpace := startOfPreviousPin - toFinger)
					  and: [bytes + (2 * manager allocationUnit) > availableSpace]]] whileTrue:
						["The object does not fit in the space between toFinger and previousPin.
						   Move toFinger up to point at the first unmarked or mobile object after
						   previousPin, or, if previousPin is contiguous with o, to the start of this
						   object.  Update previousPin to be the next pinned object above toFInger
						   and below this object, or nil if no such pinned object exists.
						   Any unfillable gaps between adjacent pinned objects will be freed."
					 	 [toFinger := manager addressAfter: previousPin.
						  previousPin := manager objectStartingAt: toFinger.
						  (manager isMarked: previousPin)
						   and: [(manager isPinned: previousPin)
						   and: [previousPin < o]]]
							whileTrue.
						 "Now previousPin is either equal to o or mobile.
						  Move it to the next pinned object below o"
						 [previousPin >= o
						  or: [(manager isMarked: previousPin)
						  and: [manager isPinned: previousPin]]] whileFalse:
							[previousPin := manager oldSpaceObjectAfter: previousPin].
						 previousPin >= o
							ifTrue: [previousPin := nil. startOfPreviousPin := 0]
							ifFalse: [startOfPreviousPin := manager startOfObject: previousPin]].
					 self forwardMobileObject: o to: toFinger savedFirstFieldPtr: top.
					 toFinger := toFinger + bytes.
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[savedFirstFieldsSpace top: top - manager bytesPerOop.
						 objectAfterLastMobileObject := manager oldSpaceObjectAfter: lastMobileObject.
						 ^false]]]].
	"If the heap is already fully compacted there will be no lastMobileObject..."
	lastMobileObject ifNotNil:
		[savedFirstFieldsSpace top: top - manager bytesPerOop.
		 objectAfterLastMobileObject := manager oldSpaceObjectAfter: lastMobileObject].
	^true