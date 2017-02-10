compaction
copyAndUnmarkMobileObjects
	"Sweep the mobile portion of the heap, moving objects to their eventual locations, and clearing their marked bits.
	 Remember to update the savedFirstFields of pointer objects, as these have been forwarded.
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
	self deny: (manager isMarked: firstFreeObject).
	toFinger := manager startOfObject: firstFreeObject.
	top := savedFirstFieldsSpace start.
	startOfPreviousPin := 0.
	manager allOldSpaceEntitiesForCompactingFrom: firstFreeObject to: (lastMobileObject ifNil: manager nilObject) do:
		[:o :n|
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
						 availableSpace > 0 ifTrue:
							[manager addFreeChunkWithBytes: availableSpace at: toFinger].
					 	 [self assert: ((manager isMarked: previousPin) and: [manager isPinned: previousPin]).
						  self unmarkPinned: previousPin.
						  toFinger := manager addressAfter: previousPin.
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
					 self copyAndUnmarkObject: o to: toFinger bytes: bytes firstField: (manager longAt: top).
					 toFinger := toFinger + bytes.
					 (top := top + manager bytesPerOop) >= savedFirstFieldsSpace limit ifTrue:
						[self assert: savedFirstFieldsSpace top = (top - manager bytesPerOop).
						 self assert: n = objectAfterLastMobileObject.
						 previousPin ifNil: [previousPin := n. startOfPreviousPin := manager startOfObject: n].
						 "Create a free object for firstFreeObject to be set to on the next pass, but
						   do not link it into the free tree as it will be written over in that next pass."
						 toFinger < startOfPreviousPin
							ifTrue:
								[firstFreeObject := manager initFreeChunkWithBytes: startOfPreviousPin - toFinger at: toFinger]
							ifFalse:
								[firstFreeObject := previousPin].
						^false]]]].
	self freeFrom: toFinger upTo: manager endOfMemory nextObject: (previousPin ifNil: [objectAfterLastMobileObject ifNil: [manager objectAfter: firstFreeObject]]).
	self coalesceFrom: toFinger.
	^true