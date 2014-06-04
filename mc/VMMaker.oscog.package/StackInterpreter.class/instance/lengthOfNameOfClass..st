debug printing
lengthOfNameOfClass: classOop
	<inline: false>
	| numSlots |
	numSlots := objectMemory numSlotsOf: classOop.
	numSlots = metaclassNumSlots ifTrue:
		[^self lengthOfNameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop)].
	numSlots <= classNameIndex ifTrue:
		[^0].
	^objectMemory lengthOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)