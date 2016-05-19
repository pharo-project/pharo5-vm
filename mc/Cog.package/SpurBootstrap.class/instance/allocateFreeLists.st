bootstrap image
allocateFreeLists
	"Allocate the freeLists array."
	| freeListsOop |
	freeListsOop := newHeap
						allocateSlots: newHeap numFreeLists
						format: newHeap wordIndexableFormat
						classIndex: newHeap wordSizeClassIndexPun.
	self assert: (newHeap objectAfter: newHeap trueObject) = freeListsOop.
	0 to: newHeap numFreeLists - 1 do:
		[:i|
		newHeap
			storePointerUnchecked: i
			ofObject: freeListsOop
			withValue: 0]