debug printing
printNameOfClass: classOop count: cnt
	"Details: The count argument is used to avoid a possible infinite recursion if classOop is a corrupted object."
	<inline: false>
	| numSlots |
	classNameIndex ifNil:
		[self print: '??nil cnidx??'.
		 ^self].
	(classOop isNil or: [classOop = 0 or: [cnt <= 0]]) ifTrue:
		[self print: 'bad class'.
		 ^self].
	numSlots := objectMemory numSlotsOf: classOop.
	(numSlots = metaclassNumSlots
	 and: [metaclassNumSlots > thisClassIndex])
		ifTrue: [self printNameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop) count: cnt - 1.
				self print: ' class']
		ifFalse:
			[numSlots <= classNameIndex
				ifTrue: [self print: 'bad class']
				ifFalse:
					[self printStringOf: (objectMemory fetchPointer: classNameIndex ofObject: classOop)]]