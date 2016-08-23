process primitive support
removeFirstLinkOfList: aList 
	"Remove the first process from the given linked list."
	| first last next |
	self deny: (objectMemory isForwarded: aList).
	first := objectMemory fetchPointer: FirstLinkIndex ofObject: aList.
	last := objectMemory fetchPointer: LastLinkIndex ofObject: aList.
	self deny: (objectMemory isForwarded: first).
	self deny: (objectMemory isForwarded: last).
	first = last
		ifTrue:
			[objectMemory
				storePointerUnchecked: FirstLinkIndex ofObject: aList withValue: objectMemory nilObject;
				storePointerUnchecked: LastLinkIndex ofObject: aList withValue: objectMemory nilObject]
		ifFalse:
			[next := objectMemory fetchPointer: NextLinkIndex ofObject: first.
			 objectMemory storePointer: FirstLinkIndex ofObject: aList withValue: next].
	objectMemory storePointerUnchecked: NextLinkIndex ofObject: first withValue: objectMemory nilObject.
	^first