private
testRandomAssortment: random with: theVM
	"Test that the compactor can handle a random assortment of live, pinned, dead, and free chunks."
	| om lastObj obj expectedFreeSpace liveFill pinFill liveCount pinCount totalLive totalPinned pinned |
	random reset. "random is a read stream on 3000 random numbers; for repeatability"
	om := theVM objectMemory.
	om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true. lastObj := o].
	pinFill := 16r99999900.
	liveFill := 16r55AA0000.
	liveCount := pinCount := expectedFreeSpace := 0.
	pinned := Set new.
	1000 timesRepeat:
		[| nSlots next newObj |
		 nSlots := (random next * 300) rounded. "Make sure we stray into overflow size field territory."
		 newObj := om allocateSlotsInOldSpace: nSlots format: om firstLongFormat classIndex: ClassByteArrayCompactIndex.
		 (next := random next) > 0.95
			ifTrue: "pinned"
				[om
					fillObj: newObj numSlots: nSlots with: pinFill + (pinCount := pinCount + 1);
					setIsPinnedOf: newObj to: true]
			ifFalse: "mobile"
				[om
					fillObj: newObj numSlots: nSlots with: liveFill + (liveCount := liveCount + 1)].
		 (next := random next) >= 0.333
			ifTrue:
				[om setIsMarkedOf: newObj to: true.
				 (om isPinned: newObj) ifTrue:
					[pinned add: newObj]]
			ifFalse: "dead or free"
				[expectedFreeSpace := expectedFreeSpace + (om bytesInObject: newObj).
				 (om isPinned: newObj) "Must check /before/ setObjectFree: which clears all bits"
					ifTrue: [pinCount := pinCount - 1]
					ifFalse: [liveCount := liveCount - 1].
				 next >= 0.2
					ifTrue: [om setIsMarkedOf: newObj to: false]
					ifFalse: [om setObjectFree: newObj]]].
	totalPinned := pinCount.
	totalLive := liveCount.
	self assert: totalPinned < (totalPinned + totalLive / 10). "should average 5%"

	"useful pre-compaction printing:"
	false ifTrue:
		[liveCount := pinCount := 0.
		 om allOldSpaceEntitiesFrom: (om objectAfter: lastObj) to: (om objectBefore: om endOfMemory) do:
			[:o|
			om coInterpreter print:
				((om isMarked: o)
					ifTrue: [(((om isPinned: o)
									ifTrue: [pinCount := pinCount + 1]
									ifFalse: [liveCount := liveCount + 1])
								printPaddedWith: Character space to: 3 base: 10), ' '] 
					ifFalse: ['     ']).
			 om printEntity: o].
		 om allOldSpaceEntitiesFrom: (om objectAfter: lastObj) to: (om objectBefore: om endOfMemory) do:
			[:o|
			((om isMarked: o) and: [om isPinned: o]) ifTrue:
				[om printEntity: o]]].

	expectedFreeSpace := expectedFreeSpace + om bytesLeftInOldSpace.
	om compactor compact.
	self assert: expectedFreeSpace equals: om bytesLeftInOldSpace.
	self assert: om allObjectsUnmarked.

	"useful post-compaction printing:"
	false ifTrue:
		[liveCount := pinCount := 0.
		 om allOldSpaceEntitiesFrom: (om objectAfter: lastObj) to: (om objectBefore: om endOfMemory) do:
			[:o|
			om coInterpreter print:
				((om isFreeObject: o)
					ifFalse: [(((om isPinned: o)
									ifTrue: [pinCount := pinCount + 1]
									ifFalse: [liveCount := liveCount + 1])
								printPaddedWith: Character space to: 3 base: 10), ' '] 
					ifTrue: ['     ']).
			 om printEntity: o].
		 om allOldSpaceEntitiesFrom: (om objectAfter: lastObj) to: (om objectBefore: om endOfMemory) do:
			[:o|
			(om isPinned: o) ifTrue:
				[om printEntity: o]]].

	"First check and/or count populations..."
	liveCount := pinCount := 0.
	om allOldSpaceObjectsFrom: (om objectAfter: lastObj) do:
		[:o|
		(om isPinned: o)
			ifTrue:
				[pinCount := pinCount + 1.
				 self assert: (pinned includes: o)]
			ifFalse: [liveCount := liveCount + 1]].
	self assert: totalPinned equals: pinCount.
	self assert: totalLive equals: liveCount.

	"Now check fills, which also tests update of first field on move..."
	liveCount := pinCount := 0.
	obj := lastObj.
	1 to: totalLive + totalPinned do:
		[:n| | expectedFill actualFill |
		 [obj := om objectAfter: obj. (om isEnumerableObject: obj) or: [obj >= om endOfMemory]] whileFalse.
		 expectedFill := (om isPinned: obj)
							ifTrue: [pinFill + (pinCount := pinCount + 1)]
							ifFalse: [liveFill + (liveCount := liveCount + 1)].
		 1 to: (om numSlotsOf: obj) do:
			[:i| self assert: expectedFill equals: (actualFill := om fetchPointer: i - 1 ofObject: obj)]].
	"They should be the last objects..."
	self assert: (om isFreeObject: (om objectAfter: obj)).
	self assert: om endOfMemory equals: (om addressAfter: (om objectAfter: obj)).
	self checkForLeaksIn: om