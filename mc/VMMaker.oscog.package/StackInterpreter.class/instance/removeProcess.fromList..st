process primitive support
removeProcess: aProcess fromList: aList 
	"Remove a given process from a linked list. May fail if aProcess is not on the list."
	| firstLink lastLink nextLink tempLink |
	self deny: (objectMemory isForwarded: aProcess).
	self deny: (objectMemory isForwarded: aList).
	firstLink := objectMemory fetchPointer: FirstLinkIndex ofObject: aList.
	lastLink := objectMemory fetchPointer: LastLinkIndex ofObject: aList.
	self deny: (objectMemory isForwarded: firstLink).
	self deny: (objectMemory isForwarded: lastLink).
	aProcess  = firstLink
		ifTrue:
			[nextLink := objectMemory fetchPointer: NextLinkIndex ofObject: aProcess.
			 self deny: (objectMemory isForwarded: nextLink).
			 objectMemory storePointer: FirstLinkIndex ofObject: aList withValue: nextLink.
			 aProcess  = lastLink ifTrue:
				[objectMemory storePointerUnchecked: LastLinkIndex ofObject: aList withValue: objectMemory nilObject]]
		ifFalse:
			[tempLink := firstLink.
			 [self deny: (objectMemory isForwarded: tempLink).
			  tempLink = objectMemory nilObject ifTrue:
				[self primitiveFail. ^self].
			  nextLink := objectMemory fetchPointer: NextLinkIndex ofObject: tempLink.
			  nextLink = aProcess] whileFalse:
				[tempLink := objectMemory fetchPointer: NextLinkIndex ofObject: tempLink].
			 nextLink := objectMemory fetchPointer: NextLinkIndex ofObject: aProcess.
			 objectMemory storePointer: NextLinkIndex ofObject: tempLink withValue: nextLink.
			 aProcess  = lastLink ifTrue:
				[objectMemory storePointer: LastLinkIndex ofObject: aList withValue: tempLink]].
	objectMemory storePointer: NextLinkIndex ofObject: aProcess withValue: objectMemory nilObject