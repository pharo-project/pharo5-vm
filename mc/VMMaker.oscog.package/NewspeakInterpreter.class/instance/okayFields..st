debug support
okayFields: oop
	"Check if the argument is an ok object.
	 If this is a pointers object, check that its fields are all okay oops."

	| i fieldOop |
	(oop = nil or: [oop = 0]) ifTrue: [ ^true ].
	(self isIntegerObject: oop) ifTrue: [ ^true ].
	(self okayOop: oop) ifFalse: [ ^false ].
	(self oopHasOkayClass: oop) ifFalse: [ ^false ].
	((self isPointers: oop) or: [self isCompiledMethod: oop]) ifFalse: [ ^true ].
	(self isCompiledMethod: oop)
		ifTrue:
			[i := (self literalCountOf: oop) + LiteralStart - 1]
		ifFalse:
			[(self isContext: oop)
				ifTrue: [i := CtxtTempFrameStart + (self fetchStackPointerOf: oop) - 1]
				ifFalse: [i := (self lengthOf: oop) - 1]].
	[i >= 0] whileTrue: [
		fieldOop := self fetchPointer: i ofObject: oop.
		(self isIntegerObject: fieldOop) ifFalse: [
			(self okayOop: fieldOop) ifFalse: [ ^false ].
			(self oopHasOkayClass: fieldOop) ifFalse: [ ^false ].
		].
		i := i - 1.
	].
	^true