process primitive support
isEmptyList: aLinkedList

	^ (self fetchPointer: FirstLinkIndex ofObject: aLinkedList) = nilObj