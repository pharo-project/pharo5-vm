obj stacks
isValidObjStack: objStack
	"Answer if the obj stack at objStackRootIndex is valid."
	((self addressCouldBeObj: objStack)
	 and: [(self numSlotsOfAny: objStack) = ObjStackPageSlots]) ifFalse:
		[objStackInvalidBecause := 'first page not obj or wrong size'.
		 invalidObjStackPage := objStack.
		 ^false].
	^self isValidObjStackPage: objStack
		myIndex: (self fetchPointer: ObjStackMyx ofObject: objStack)
		firstPage: true