debug printing
nameOfClass: classOop
	"Brain-damaged nameOfClass: for C VM.  Does *not* answer Foo class for metaclasses.
	 Use e.g. classIsMeta: to avoid being fooled."
	<inline: false>
	<returnTypeC: 'char *'>
	| numSlots |
	numSlots := objectMemory numSlotsOf: classOop.
	numSlots = metaclassNumSlots ifTrue:
		[^self nameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop)].
	numSlots <= classNameIndex ifTrue:
		[^'bad class'].
	^objectMemory firstIndexableField: (objectMemory fetchPointer: classNameIndex ofObject: classOop)