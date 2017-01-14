debug printing
nameOfClass: classOop
	"Brain-damaged nameOfClass: for C VM.  Does *not* answer Foo class for metaclasses.
	 Use e.g. classIsMeta: to avoid being fooled."
	<inline: false>
	<returnTypeC: #'char *'>
	| numSlots maybeNameOop maybeThisClassOop |
	numSlots := objectMemory numSlotsOf: classOop.
	numSlots = metaclassNumSlots ifTrue:
		[maybeThisClassOop := objectMemory fetchPointer: thisClassIndex ofObject: classOop.
		(self addressCouldBeClassObj: maybeThisClassOop) ifTrue:
			[^self nameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop)].
		 ^'bad class'].
	(numSlots > classNameIndex
	 and: [maybeNameOop := objectMemory fetchPointer: classNameIndex ofObject: classOop.
		objectMemory isBytes: maybeNameOop]) ifFalse:
		[^'bad class'].
	^objectMemory firstIndexableField: maybeNameOop