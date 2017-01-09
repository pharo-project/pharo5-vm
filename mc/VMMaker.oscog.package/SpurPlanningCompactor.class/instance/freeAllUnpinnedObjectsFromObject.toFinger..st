private
freeAllUnpinnedObjectsFromObject: nextObj toFinger: initialToFinger
	"Free all space from toFinger up, preserving only marked pinned objects."
	| toFinger nextPinnedObj |
	<var: 'toFinger' type: #usqInt>
	<var: 'nextPinnedObj' type: #usqInt>
	toFinger := initialToFinger.
	nextPinnedObj := nextObj.
	[[nextPinnedObj >= manager endOfMemory
	  or: [(manager isMarked: nextPinnedObj)
		  and: [(manager isPinned: nextPinnedObj)]]] whileFalse:
		[nextPinnedObj := manager objectAfter: nextPinnedObj].
	 nextPinnedObj < manager endOfMemory] whileTrue:
		[toFinger < (manager startOfObject: nextPinnedObj) ifTrue:
			[manager addFreeChunkWithBytes: (manager startOfObject: nextPinnedObj) - toFinger at: toFinger].
		 toFinger := manager addressAfter: nextPinnedObj.
		 nextPinnedObj := manager objectAfter: nextPinnedObj].
	toFinger < manager endOfMemory ifTrue:
		[manager addFreeChunkWithBytes: manager endOfMemory - toFinger at: toFinger]