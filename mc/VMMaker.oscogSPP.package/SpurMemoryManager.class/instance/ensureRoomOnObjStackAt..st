obj stacks
ensureRoomOnObjStackAt: objStackRootIndex
	"An obj stack is a stack of objects stored in a hidden root slot, such as
	 the markStack or the ephemeronQueue.  It is a linked list of segments,
	 with the hot end at the head of the list.  It is a word object.  The stack
	 pointer is in ObjStackTopx and 0 means empty.  The list goes through
	 ObjStackNextx. We don't want to shrink objStacks, since they're used
	 in GC and its good to keep their memory around.  So unused pages
	 created by popping emptying pages are kept on the ObjStackFreex list."
	| stackOrNil freeOrNewPage |
	stackOrNil := self fetchPointer: objStackRootIndex ofObject: hiddenRootsObj.
	(stackOrNil = nilObj
	 or: [(self fetchPointer: ObjStackTopx ofObject: stackOrNil) >= ObjStackLimit]) ifTrue:
		[freeOrNewPage := stackOrNil = nilObj
								ifTrue: [0]
								ifFalse: [self fetchPointer: ObjStackFreex ofObject: stackOrNil].
		 freeOrNewPage ~= 0
			ifTrue: "the free page list is always on the new page."
				[self storePointer: ObjStackFreex ofObjStack: stackOrNil withValue: 0.
				 self assert: (marking not or: [self isMarked: freeOrNewPage])]
			ifFalse:
				[freeOrNewPage := self allocateSlotsInOldSpace: ObjStackPageSlots
										format: self wordIndexableFormat
										classIndex: self wordSizeClassIndexPun.
				 freeOrNewPage ifNil: [self error: 'no memory to allocate or extend obj stack'].
				 self storePointer: ObjStackFreex ofObjStack: freeOrNewPage withValue: 0.
				 marking ifTrue: [self setIsMarkedOf: freeOrNewPage to: true]].
		 self storePointer: ObjStackMyx ofObjStack: freeOrNewPage withValue: objStackRootIndex;
			  storePointer: ObjStackNextx ofObjStack: freeOrNewPage withValue: (stackOrNil = nilObj ifTrue: [0] ifFalse: [stackOrNil]);
			  storePointer: ObjStackTopx ofObjStack: freeOrNewPage withValue: 0;
			  storePointer: objStackRootIndex ofObject: hiddenRootsObj withValue: freeOrNewPage.
		 self assert: (self isValidObjStackAt: objStackRootIndex).
		 "Added a new page; now update and answer the relevant cached first page."
		 stackOrNil := self updateRootOfObjStackAt: objStackRootIndex with: freeOrNewPage].
	self assert: (self isValidObjStackAt: objStackRootIndex).
	^stackOrNil