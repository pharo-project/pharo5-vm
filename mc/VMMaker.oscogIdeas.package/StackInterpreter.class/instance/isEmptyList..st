process primitive support
isEmptyList: aLinkedList
	self assert: (objectMemory isForwarded: aLinkedList) not.
	^ (objectMemory fetchPointer: FirstLinkIndex ofObject: aLinkedList) = objectMemory nilObject