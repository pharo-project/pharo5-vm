debug support
okayFields: oop
	"If this is a pointers object, check that its fields are all okay oops."

	| i fieldOop c |
	(oop = nil or: [oop = 0]) ifTrue: [ ^true ].
	(self isIntegerObject: oop) ifTrue: [ ^true ].
	self okayOop: oop.
	self oopHasOkayClass: oop.
	(self isPointers: oop) ifFalse: [ ^true ].
	c := self fetchClassOf: oop.
	(c = (self splObj: ClassMethodContext)
		or: [c = (self splObj: ClassBlockContext)])
		ifTrue: [i := CtxtTempFrameStart + (self fetchStackPointerOf: oop) - 1]
		ifFalse: [i := (self lengthOf: oop) - 1].
	[i >= 0] whileTrue: [
		fieldOop := self fetchPointer: i ofObject: oop.
		(self isIntegerObject: fieldOop) ifFalse: [
			self okayOop: fieldOop.
			self oopHasOkayClass: fieldOop.
		].
		i := i - 1.
	].