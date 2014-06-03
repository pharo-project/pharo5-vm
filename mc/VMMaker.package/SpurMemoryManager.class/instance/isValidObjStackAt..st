obj stacks
isValidObjStackAt: objStackRootIndex
	"Answer if the obj stack at objStackRootIndex is valid."
	| stackOrNil |
	stackOrNil := self fetchPointer: objStackRootIndex ofObject: hiddenRootsObj.
	^stackOrNil = nilObj
	  or: [self isValidObjStackPage: stackOrNil myIndex: objStackRootIndex firstPage: true]