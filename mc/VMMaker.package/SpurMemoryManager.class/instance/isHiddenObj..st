debug support
isHiddenObj: objOop
	^objOop =  self freeListsObject
	  or: [(self numSlotsOfAny: objOop) = ObjStackPageSlots
		and: [self isValidObjStackPage: objOop myIndex: (self fetchPointer: ObjStackMyx ofObject: objOop)]]