private
testRandomAssortment: random
	"Test that the compactor can handle a random assortment of live, pinned, dead, and free chunks."
	| om lastObj obj expectedFreeSpace liveFill pinFill liveCounter pinCounter totalLive totalPinned |
	random reset. "random is a read stream on 3000 random numbers; for repeatability"
	om := self initializedVM objectMemory.
	om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true. lastObj := o].
	pinFill := 16r99999900.
	liveFill := 16r55AA0000.
	liveCounter := pinCounter := expectedFreeSpace := 0.
	1000 timesRepeat:
		[| nSlots next newObj |
		 nSlots := (random next * 300) rounded. "Make sure we stray into overflow size field territory."
		 newObj := om allocateSlotsInOldSpace: nSlots format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
		 (next := random next) > 0.95
			ifTrue: "pinned"
				[om
					fillObj: newObj numSlots: nSlots with: pinFill + (pinCounter := pinCounter + 1);
					setIsPinnedOf: newObj to: true]
			ifFalse: "mobile"
				[om
					fillObj: newObj numSlots: nSlots with: liveFill + (liveCounter := liveCounter + 1)].
		 (next := random next) >= 0.333
			ifTrue:
				[om setIsMarkedOf: newObj to: true]
			ifFalse: "dead or free"
				[expectedFreeSpace := expectedFreeSpace + (om bytesInObject: newObj).
				 (om isPinned: newObj) "Must check /before/ setObjectFree: which clears all bits"
					ifTrue: [pinCounter := pinCounter - 1]
					ifFalse: [liveCounter := liveCounter - 1].
				 next >= 0.2
					ifTrue: [om setIsMarkedOf: newObj to: false]
					ifFalse: [om setObjectFree: newObj]]].
	totalPinned := pinCounter.
	totalLive := liveCounter.
	self assert: totalPinned < (totalPinned + totalLive / 10). "should be about 5%"

	"Check our checking code before the compaction, just in case..."
	liveCounter := pinCounter := 0.
	obj := lastObj.
	1 to: totalLive + totalPinned do:
		[:n| | expectedFill actualFill |
		 [obj := om objectAfter: obj. (om isEnumerableObject: obj) and: [om isMarked: obj]] whileFalse.
		 expectedFill := (om isPinned: obj)
							ifTrue: [pinFill + (pinCounter := pinCounter + 1)]
							ifFalse: [liveFill + (liveCounter := liveCounter + 1)].
		 1 to: (om numSlotsOf: obj) do:
			[:i| self assert: expectedFill equals: (actualFill := om fetchPointer: i - 1 ofObject: obj)]].

	"useful debugging:""om printOopsFrom: (om objectAfter: lastObj) to: om endOfMemory"
	expectedFreeSpace := expectedFreeSpace + om bytesLeftInOldSpace.
	om compactor compact.
	self assert: expectedFreeSpace equals: om bytesLeftInOldSpace.
	self assert: om allObjectsUnmarked.

	liveCounter := pinCounter := 0.
	obj := lastObj.
	1 to: totalLive + totalPinned do:
		[:n| | expectedFill actualFill |
		 [obj := om objectAfter: obj. (om isEnumerableObject: obj) or: [obj >= om endOfMemory]] whileFalse.
		 expectedFill := (om isPinned: obj)
							ifTrue: [pinFill + (pinCounter := pinCounter + 1)]
							ifFalse: [liveFill + (liveCounter := liveCounter + 1)].
		 1 to: (om numSlotsOf: obj) do:
			[:i| self assert: expectedFill equals: (actualFill := om fetchPointer: i - 1 ofObject: obj)]].
	"They should be the last objects..."
	self assert: (om isFreeObject: (om objectAfter: obj)).
	self assert: om endOfMemory equals: (om addressAfter: (om objectAfter: obj))