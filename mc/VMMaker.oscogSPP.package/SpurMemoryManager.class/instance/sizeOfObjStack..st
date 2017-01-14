obj stacks
sizeOfObjStack: objStack
	| total objStackPage |
	objStack = nilObj ifTrue: [^0].
	total := self fetchPointer: ObjStackTopx ofObject: objStack.
	objStackPage := objStack.
	[objStackPage := self fetchPointer: ObjStackNextx ofObject: objStackPage.
	 objStackPage ~= 0] whileTrue:
		[total := total + ObjStackLimit.
		 self assert: (self fetchPointer: ObjStackTopx ofObject: objStackPage) = ObjStackLimit].
	^total