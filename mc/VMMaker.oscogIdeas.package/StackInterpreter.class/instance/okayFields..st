debug support
okayFields: oop
	"Check if the argument is an ok object.
	 If this is a pointers object, check that its fields are all okay oops."

	| i fieldOop |
	(oop = nil or: [oop = 0]) ifTrue: [ ^true ].
	(objectMemory isIntegerObject: oop) ifTrue: [ ^true ].
	(objectMemory okayOop: oop) ifFalse: [ ^false ].
	(objectMemory oopHasOkayClass: oop) ifFalse: [ ^false ].
	((objectMemory isPointersNonImm: oop) or: [objectMemory isCompiledMethod: oop]) ifFalse: [ ^true ].
	(objectMemory isCompiledMethod: oop)
		ifTrue:
			[i := (objectMemory literalCountOf: oop) + LiteralStart - 1]
		ifFalse:
			[(objectMemory isContext: oop)
				ifTrue: [i := CtxtTempFrameStart + (self fetchStackPointerOf: oop) - 1]
				ifFalse: [i := (objectMemory lengthOf: oop) - 1]].
	[i >= 0] whileTrue: [
		fieldOop := objectMemory fetchPointer: i ofObject: oop.
		(objectMemory isIntegerObject: fieldOop) ifFalse: [
			(objectMemory okayOop: fieldOop) ifFalse: [ ^false ].
			(self oopHasOkayClass: fieldOop) ifFalse: [ ^false ].
		].
		i := i - 1.
	].
	^true