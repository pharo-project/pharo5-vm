private
unmarkPinnedObjectsAndFindFirstUnpinnedOrFreeEntityFollowing: pinnedObj
	<inline: true>
	| nextObj |
	self assert: ((manager isPinned: pinnedObj) and: [manager isMarked: pinnedObj]).
	nextObj := pinnedObj.
	[self unmarkPinned: nextObj.
	 nextObj := manager objectAfter: nextObj limit: manager endOfMemory.
	 nextObj >= manager endOfMemory ifTrue:
		[^manager endOfMemory].
	 (manager isPinned: nextObj) and: [manager isMarked: nextObj]] whileTrue.
	^nextObj