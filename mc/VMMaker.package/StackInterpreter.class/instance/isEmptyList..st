process primitive support
isEmptyList: aLinkedList

	^ (objectMemory fetchPointer: FirstLinkIndex ofObject: aLinkedList) = objectMemory nilObject