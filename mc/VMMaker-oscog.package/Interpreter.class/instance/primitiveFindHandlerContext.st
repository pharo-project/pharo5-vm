process primitives
primitiveFindHandlerContext
	"Primitive. Search up the context stack for the next method context marked for exception handling starting at the receiver. Return nil if none found"
	| thisCntx nilOop |
	thisCntx := self popStack.
	nilOop := nilObj.

	[(self isHandlerMarked: thisCntx) ifTrue:[
			self push: thisCntx.
			^nil].
		thisCntx := self fetchPointer: SenderIndex ofObject: thisCntx.
		thisCntx = nilOop] whileFalse.

	^self push: nilObj