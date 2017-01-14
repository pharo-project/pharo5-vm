process primitive support
addFirstLink: proc toList: aList 
	"Add the given process to the front of the given linked list
	 and set the backpointer of process to its new list."
	| firstLink |
	self assert: (objectMemory isForwarded: aList) not.
	self assert: (objectMemory fetchPointer: NextLinkIndex ofObject: proc) = objectMemory nilObject.
	firstLink := objectMemory fetchPointer: FirstLinkIndex ofObject: aList.
	self assert: firstLink ~= proc.
	objectMemory storePointer: FirstLinkIndex ofObject: aList withValue: proc.
	firstLink = objectMemory nilObject "a.k.a. (self isEmptyList: aList)"
		ifTrue: [objectMemory storePointer: LastLinkIndex ofObject: aList withValue: proc]
		ifFalse: [objectMemory storePointer: NextLinkIndex ofObject: proc withValue: firstLink].
	objectMemory storePointer: MyListIndex ofObject: proc withValue: aList