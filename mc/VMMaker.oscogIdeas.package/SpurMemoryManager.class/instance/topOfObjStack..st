obj stacks
topOfObjStack: objStack
	| topx |
	"This assert is tricky.  push:onObjStack: may call topOfObjStack: just after pushing an
	 empty page on the stack, and will ask if the second page is valid."
	self eassert: [self isValidObjStackPage: objStack
					myIndex: (self fetchPointer: ObjStackMyx ofObject: objStack)
					firstPage: (objStack = (self fetchPointer: (self fetchPointer: ObjStackMyx ofObject: objStack) ofObject: hiddenRootsObj))].
	topx := self fetchPointer: ObjStackTopx ofObject: objStack.
	topx = 0 ifTrue:
		[self assert: (self fetchPointer: ObjStackNextx ofObject: objStack) = 0.
		^nil].
	^self fetchPointer: topx + ObjStackFixedSlots - 1 ofObject: objStack