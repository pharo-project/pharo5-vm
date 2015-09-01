obj stacks
updateRootOfObjStackAt: objStackRootIndex with: newRootPage
	self storePointer: objStackRootIndex
		ofObject: hiddenRootsObj
		withValue: newRootPage.
	objStackRootIndex caseOf: {
		[MarkStackRootIndex]		->	[markStack := newRootPage].
		[WeaklingStackRootIndex]	->	[weaklingStack := newRootPage].
		[MournQueueRootIndex]	->	[mournQueue := newRootPage] }.
	^newRootPage