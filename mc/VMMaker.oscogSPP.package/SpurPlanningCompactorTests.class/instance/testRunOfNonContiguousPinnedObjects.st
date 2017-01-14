tests
testRunOfNonContiguousPinnedObjects
	"Test that the compactor can handle a long run of adjacent pinned objects separated by small ammounts of free space, across which it can and must move some unpinned objects."
	| om expectedFreeSpace firstPinnedObj gapObj obj numPins |
	om := self initializedVM objectMemory.
	om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true].
	"First create a gap"
	gapObj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassArrayCompactIndex.
	om fillObj: gapObj numSlots: 100 with: om falseObject.
	self deny: (om isMarked: gapObj).
	"Now a long run of pinned objects."
	(numPins := 20) timesRepeat:
		[obj := om allocateSlotsInOldSpace: 4 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
		 om
			fillObj: obj numSlots: 4 with: 16r99999999;
			setIsPinnedOf: obj to: true;
			setIsMarkedOf: obj to: true.
		 firstPinnedObj ifNil:
			[firstPinnedObj := obj].
		 om allocateSlotsInOldSpace: 4 format: om firstLongFormat classIndex: ClassArrayCompactIndex].
	"Now something to move around it."
	obj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
	om fillObj: obj numSlots: 100 with: 16r55AA55AA;
		setIsMarkedOf: obj to: true.
	"And something to move to the end of it."
	obj := om allocateSlotsInOldSpace: 100 format: om firstLongFormat classIndex: ClassBitmapCompactIndex.
	om fillObj: obj numSlots: 100 with: 16rAA55AA55;
		setIsMarkedOf: obj to: true.

	"useful debugging:""om printOopsFrom: gapObj to: om endOfMemory"
	expectedFreeSpace := om bytesLeftInOldSpace + (om bytesInObject: gapObj) + ((om bytesInObject: firstPinnedObj) * numPins).
	om compactor compact.
	self assert: expectedFreeSpace equals: om bytesLeftInOldSpace.
	self assert: om allObjectsUnmarked.

	"The first mobile object past the pinned objects should have moved."
	self assert: ClassBitmapCompactIndex equals: (om classIndexOf: gapObj).
	self deny: (om isPinned: gapObj). 
	0 to: 99 do: [:i| self assert: 16r55AA55AA equals: (om fetchPointer: i ofObject: gapObj)].
	"The pinned objects should not have moved."
	obj := firstPinnedObj.
	1 to: numPins do:
		[:n|
		 self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
		 0 to: 3 do: [:i| self assert: 16r99999999 equals: (om fetchPointer: i ofObject: obj)].
		 obj := om objectAfter: obj.
		 n < numPins ifTrue:
			[self assert: (om isFreeObject: obj).
			 obj := om objectAfter: obj]].
	"The last object should have moved down."
	self assert: ClassBitmapCompactIndex equals: (om classIndexOf: obj).
	self deny: (om isPinned: obj). 
	0 to: 99 do: [:i| self assert: 16rAA55AA55 equals: (om fetchPointer: i ofObject: obj)].
	"It should be the last object..."
	self assert: (om isFreeObject: (om objectAfter: obj)).
	self assert: om endOfMemory equals: (om addressAfter: (om objectAfter: obj))
		