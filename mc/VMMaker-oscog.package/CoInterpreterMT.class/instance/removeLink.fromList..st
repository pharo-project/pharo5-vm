process primitive support
removeLink: aLink fromList: aLinkedList
	| linksNextLink tempLink lastLink nextLink |
	linksNextLink := objectMemory fetchPointer: NextLinkIndex ofObject: aLink.
	tempLink := objectMemory fetchPointer: FirstLinkIndex ofObject: aLinkedList.
	lastLink := objectMemory fetchPointer: LastLinkIndex ofObject: aLinkedList.
	aLink = tempLink
		ifTrue:
			[objectMemory storePointer: FirstLinkIndex
				ofObject: aLinkedList
				withValue: linksNextLink.
			 aLink = lastLink ifTrue:
				[objectMemory storePointerUnchecked: LastLinkIndex
					ofObject: aLinkedList
					withValue: objectMemory nilObject]]
		ifFalse:
			[[tempLink = objectMemory nilObject ifTrue: [self error: 'link is not on list'].
			  nextLink := objectMemory fetchPointer: NextLinkIndex ofObject: tempLink.
			  nextLink = aLink] whileFalse:
				[tempLink := nextLink].
			 objectMemory storePointer: NextLinkIndex
				ofObject: tempLink
				withValue: linksNextLink.
			aLink = lastLink ifTrue:
				[objectMemory storePointer: LastLinkIndex
					ofObject: aLinkedList
					withValue: tempLink]].
	objectMemory storePointer: NextLinkIndex ofObject: aLink withValue: objectMemory nilObject.
	^aLink