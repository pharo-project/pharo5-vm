tests
testRunOfNonContiguousPinnedObjectsWithSpaceInBetween
	"Test that the compactor can handle a long run of adjacent pinned objects separated by large ammounts of free space, into which it can and must move some unpinned objects."
	| om expectedFreeSpace firstPinnedObj gapObj obj numPins firstFreeObj |
	om := self initializedVM objectMemory.
	om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true].
	"First create a gap"
	gapObj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassArrayCompactIndex.
	om fillObj: gapObj numSlots: 100 with: om falseObject.
	self deny: (om isMarked: gapObj).
	"Now a long run of pinned objects."
	(numPins := 10) timesRepeat:
		[obj := om allocateSlotsInOldSpace: 4 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
		 om
			fillObj: obj numSlots: 4 with: 16r99999999;
			setIsPinnedOf: obj to: true;
			setIsMarkedOf: obj to: true.
		 firstPinnedObj ifNil:
			[firstPinnedObj := obj].
		 obj := om allocateSlotsInOldSpace: 104 format: om firstLongFormat classIndex: ClassArrayCompactIndex.
		 firstFreeObj ifNil:
			[firstFreeObj := obj]].
	self deny: (om isMarked: firstFreeObj).
	"Now some objects to move around and into the run of pinned objects."
	numPins timesRepeat:
		[obj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
		 om fillObj: obj numSlots: 100 with: 16r55AA55AA;
			setIsMarkedOf: obj to: true.
		 obj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
		 om fillObj: obj numSlots: 100 with: 16rAA55AA55;
			setIsMarkedOf: obj to: true].

	"useful debugging:""om printOopsFrom: gapObj to: om endOfMemory"
	expectedFreeSpace := om bytesLeftInOldSpace + (om bytesInObject: gapObj) + ((om bytesInObject: firstFreeObj) * numPins).
	om compactor compact.
	self assert: expectedFreeSpace equals: om bytesLeftInOldSpace.
	self assert: om allObjectsUnmarked.

	"The first mobile object past the pinned objects should have moved. The pinned objects should not have moved.
	 We should see moved obj, pinned obj, (moved obj, free obj, pinned obj) +"
	obj := gapObj.
	1 to: numPins do:
		[:n|
		 self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 self deny: (om isPinned: obj). 
		 0 to: 99 do: [:i| self assert: (n odd ifTrue: [16r55AA55AA] ifFalse: [16rAA55AA55]) equals: (om fetchPointer: i ofObject: obj)].
		 obj := om objectAfter: obj.
		 n > 1 ifTrue:
			[self assert: (om isFreeObject: obj).
			 obj := om objectAfter: obj].
		 self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 self assert: (om isPinned: obj).
		 0 to: 3 do: [:i| self assert: 16r99999999 equals: (om fetchPointer: i ofObject: obj)].
		 obj := om objectAfter: obj].
	"The last objects should have moved down."
	1 to: numPins do:
		[:n|
		 self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 self deny: (om isPinned: obj). 
		 0 to: 99 do: [:i| self assert: (n odd ifTrue: [16r55AA55AA] ifFalse: [16rAA55AA55]) equals: (om fetchPointer: i ofObject: obj)]..
		 obj := om objectAfter: obj].
	"They should be the last objects..."
	self assert: (om isFreeObject: obj).
	self assert: om endOfMemory equals: (om addressAfter: obj)
		