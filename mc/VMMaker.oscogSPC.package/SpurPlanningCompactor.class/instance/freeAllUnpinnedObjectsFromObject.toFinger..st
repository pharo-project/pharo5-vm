private
freeAllUnpinnedObjectsFromObject: nextObj toFinger: initialToFinger
	"Free all space from toFinger up, preserving only marked pinned objects, clearning their marked bits."
	| toFinger nextPinnedObj |
	<var: 'toFinger' type: #usqInt>
	<var: 'nextPinnedObj' type: #usqInt>
	toFinger := initialToFinger.
	nextPinnedObj := nextObj.
	[[nextPinnedObj >= manager endOfMemory
	  or: [(manager isMarked: nextPinnedObj)
		  and: [manager isPinned: nextPinnedObj]]] whileFalse:
		[nextPinnedObj := manager objectAfter: nextPinnedObj].
	 nextPinnedObj < manager endOfMemory] whileTrue:
		[toFinger < (manager startOfObject: nextPinnedObj) ifTrue:
			[manager addFreeChunkWithBytes: (manager startOfObject: nextPinnedObj) - toFinger at: toFinger].
		 self unmarkPinned: nextPinnedObj.
		 toFinger := manager addressAfter: nextPinnedObj.
		 nextPinnedObj := manager objectAfter: nextPinnedObj].
	toFinger < manager endOfMemory ifTrue:
		[manager addFreeChunkWithBytes: manager endOfMemory - toFinger at: toFinger]