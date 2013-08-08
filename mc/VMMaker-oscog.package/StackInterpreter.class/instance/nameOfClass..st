debug printing
nameOfClass: classOop
	"Brain-damaged nameOfClass: for C VM.  Does *not* answer Foo class for metaclasses.
	 Use e.g. classIsMeta: to avoid being fooled."
	<inline: false>
	<returnTypeC: 'char *'>
	(objectMemory sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[^self nameOfClass: (objectMemory fetchPointer: thisClassIndex ofObject: classOop)].
	^objectMemory firstFixedField: (objectMemory fetchPointer: classNameIndex ofObject: classOop)