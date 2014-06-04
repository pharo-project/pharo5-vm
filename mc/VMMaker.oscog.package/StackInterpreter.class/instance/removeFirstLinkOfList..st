process primitive support
removeFirstLinkOfList: aList 
	"Remove the first process from the given linked list."
	| first last next |
	first := objectMemory fetchPointer: FirstLinkIndex ofObject: aList.
	last := objectMemory fetchPointer: LastLinkIndex ofObject: aList.
	first = last
		ifTrue: [objectMemory storePointer: FirstLinkIndex ofObject: aList withValue: objectMemory nilObject.
			objectMemory storePointer: LastLinkIndex ofObject: aList withValue: objectMemory nilObject]
		ifFalse: [next := objectMemory fetchPointer: NextLinkIndex ofObject: first.
			objectMemory storePointer: FirstLinkIndex ofObject: aList withValue: next].
	objectMemory storePointer: NextLinkIndex ofObject: first withValue: objectMemory nilObject.
	^ first