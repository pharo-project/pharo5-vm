private
findNextMarkedPinnedAfter: unpinnedObj
	<inline: true>
	| nextObj |
	self deny: ((manager isPinned: unpinnedObj) and: [manager isMarked: unpinnedObj]).
	nextObj := unpinnedObj.
	[nextObj := manager objectAfter: nextObj limit: manager endOfMemory.
	 nextObj >= manager endOfMemory ifTrue:
		[^nil].
	 (manager isPinned: nextObj) and: [manager isMarked: nextObj]] whileFalse.
	^nextObj