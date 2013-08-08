process primitive support
addLastLink: proc toList: aList 
	"Add the given process to the given linked list and set the 
	backpointer of process to its new list."
	| lastLink |
	(self isEmptyList: aList)
		ifTrue: [self storePointer: FirstLinkIndex ofObject: aList withValue: proc]
		ifFalse: [lastLink := self fetchPointer: LastLinkIndex ofObject: aList.
			self storePointer: NextLinkIndex ofObject: lastLink withValue: proc].
	self storePointer: LastLinkIndex ofObject: aList withValue: proc.
	self storePointer: MyListIndex ofObject: proc withValue: aList