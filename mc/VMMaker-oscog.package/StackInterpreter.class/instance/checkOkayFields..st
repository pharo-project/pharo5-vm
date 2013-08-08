debug support
checkOkayFields: oop
	"Check if the argument is an ok object.
	 If this is a pointers object, check that its fields are all okay oops."

	| hasYoung i fieldOop |
	(oop = nil or: [oop = 0]) ifTrue: [ ^true ]. "?? eem 1/16/2013"
	(objectMemory isIntegerObject: oop) ifTrue: [ ^true ].
	(objectMemory checkOkayOop: oop) ifFalse: [ ^false ].
	(self checkOopHasOkayClass: oop) ifFalse: [ ^false ].
	hasYoung := objectMemory isYoung: (objectMemory fetchClassOfNonInt: oop).
	((objectMemory isPointersNonInt: oop) or: [objectMemory isCompiledMethod: oop]) ifTrue:
		[(objectMemory isCompiledMethod: oop)
			ifTrue:
				[i := (self literalCountOf: oop) - 1]
			ifFalse:
				[(objectMemory isContext: oop)
					ifTrue: [i := CtxtTempFrameStart + (self fetchStackPointerOf: oop) - 1]
					ifFalse: [i := (objectMemory lengthOf: oop) - 1]].
		[i >= 0] whileTrue:
			[fieldOop := objectMemory fetchPointer: i ofObject: oop.
			(objectMemory isIntegerObject: fieldOop) ifFalse:
				[hasYoung := hasYoung or: [objectMemory isYoung: fieldOop].
				(objectMemory checkOkayOop: fieldOop) ifFalse: [ ^false ].
				(self checkOopHasOkayClass: fieldOop) ifFalse: [ ^false ]].
			i := i - 1]].
	hasYoung ifTrue:
		[^objectMemory checkOkayYoungReferrer: oop].
	^true