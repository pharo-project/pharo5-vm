debug support
nameOfClass: classOop
	| numSlots |
	classNameIndex ifNil: [^'??nil cnidx??'].
	numSlots := objectMemory numSlotsOf: classOop.
	numSlots = metaclassNumSlots ifTrue:
		[^(self nameOfClass:
				(objectMemory fetchPointer: thisClassIndex ofObject: classOop)) , ' class'].
	numSlots <= classNameIndex ifTrue:
		[^'bad class'].
	^self stringOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)