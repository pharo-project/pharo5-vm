private
firstUnpinnedObjectFollowing: pinnedObj
	| nextObj |
	self assert: (manager isPinned: pinnedObj).
	nextObj := pinnedObj.
	[nextObj := manager objectAfter: nextObj limit: manager endOfMemory.
	 nextObj >= manager endOfMemory ifTrue:
		[^manager endOfMemory].
	 manager isPinned: nextObj] whileTrue.
	^nextObj