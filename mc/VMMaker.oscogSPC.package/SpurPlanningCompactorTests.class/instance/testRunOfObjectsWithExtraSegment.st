tests
testRunOfObjectsWithExtraSegment
	"Test that the compactor can handle compacting more than one segment and shortening the memory."
	| om expectedFreeSpace pig gapObj obj |
	om := self initializedVM objectMemory.
	om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true].
	"First create a gap"
	gapObj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassArrayCompactIndex.
	om fillObj: gapObj numSlots: 100 with: om falseObject.
	self deny: (om isMarked: gapObj).
	expectedFreeSpace := om bytesInObject: gapObj.
	"Now some objects, a gap to a new segment and another run of objects."
	1 to: 2 do:
		[:i|
		10 timesRepeat:
			[obj := om allocateSlotsInOldSpace: 50 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
			 om fillObj: obj numSlots: 50 with: 16r55AA55AA;
				setIsMarkedOf: obj to: true.
			 obj := om allocateSlotsInOldSpace: 260 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
			om fillObj: obj numSlots: 260 with: 16rAA55AA55;
				setIsMarkedOf: obj to: true].
		i = 1 ifTrue:
			[pig := om allocateSlotsInOldSpace: (om numSlotsOfAny: om findLargestFreeChunk) format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
			 self deny: pig isNil.
			 self assert: 0 equals: om bytesLeftInOldSpace.
			 om growOldSpaceByAtLeast: om growHeadroom // 2.
			 self assert: om growHeadroom equals: om bytesLeftInOldSpace + om bridgeSize.
			 expectedFreeSpace := expectedFreeSpace + (om bytesInObject: pig)]].

	"useful debugging:""om printOopsFrom: gapObj to: om endOfMemory"
	expectedFreeSpace := expectedFreeSpace + om bytesLeftInOldSpace.
	om compactor compact.
	self assert: expectedFreeSpace equals: om bytesLeftInOldSpace.
	self assert: om allObjectsUnmarked.

	"The first mobile object past the pinned objects should have moved."
	self assert: ClassBitmapCompactIndex equals: (om classIndexOf: gapObj).
	obj := gapObj.
	"The objects have moved."
	20 timesRepeat:
		[self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 0 to: (om numSlotsOf: obj) - 1 do: [:i| self assert: 16r55AA55AA equals: (om fetchPointer: i ofObject: obj)].
		 obj := om objectAfter: obj.
		 self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 0 to: (om numSlotsOf: obj) - 1 do: [:i| self assert: 16rAA55AA55 equals: (om fetchPointer: i ofObject: obj)].
		 obj := om objectAfter: obj].
	"the Last segment should be empty"
	self assert: (om segmentManager isEmptySegment: (om segmentManager segments at: 1)).
	"They should be the last objects, followed by a free object to the end fo the first segment, a bridge, then an empty segment with a single free object in it."
	self assert: (om isFreeObject: obj).
	self assert: (om isSegmentBridge: (om objectAfter: obj)).
	self assert: (om isFreeObject: (om objectAfter: (om objectAfter: obj))).
	self assert: om endOfMemory equals: (om addressAfter: (om objectAfter: (om objectAfter: obj))).

	"And the memory should shrink if the shrinkThreshold is low enough"
	om shrinkThreshold: om growHeadroom.
	om attemptToShrink.
	self assert: om segmentManager numSegments = 1