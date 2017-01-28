private
findNextMarkedPinnedAfter: unpinnedObj
	<inline: true>
	| nextObj |
	self deny: ((manager isPinned: unpinnedObj) and: [manager isMarked: unpinnedObj]).
	nextObj := unpinnedObj.
	[nextObj := manager oldSpaceObjectAfter: nextObj.
	 (self oop: nextObj isGreaterThanOrEqualTo: manager endOfMemory) ifTrue:
		[^nil].
	 (manager isPinned: nextObj) and: [manager isMarked: nextObj]] whileFalse.
	^nextObj