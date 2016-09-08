obj stacks
emptyObjStack: objStack
	"Remove all the entries on the stack.  Do so by setting Topx to 0
	 on the first page, and adding all subsequent pages to the free list."
	| nextPage nextNextPage |
	objStack = nilObj ifTrue:
		[^self].
	self eassert: [self isValidObjStack: objStack].
	self storePointer: ObjStackTopx ofObjStack: objStack withValue: 0.
	nextPage := self fetchPointer: ObjStackNextx ofObject: objStack.
	[nextPage ~= 0] whileTrue:
		[nextNextPage := self fetchPointer: ObjStackNextx ofObject: nextPage.
		 self storePointer: ObjStackFreex
			ofObjStack: nextPage
			withValue: (self fetchPointer: ObjStackFreex ofObject: objStack).
		 self storePointer: ObjStackNextx ofObjStack: nextPage withValue: 0.
		 self storePointer: ObjStackFreex ofObjStack: objStack withValue: nextPage.
		 nextPage := nextNextPage].
	self storePointer: ObjStackNextx ofObjStack: objStack withValue: 0.
	self eassert: [self isValidObjStack: objStack]