debug printing
nameOfClass: classOop
	"Brain-damaged nameOfClass: for C VM.  Does *not* answer Foo class for metaclasses.
	 Use e.g. classIsMeta: to avoid being fooled."
	<inline: false>
	<returnTypeC: 'char *'>
	(self sizeBitsOf: classOop) = metaclassSizeBits ifTrue:
		[^self nameOfClass: (self fetchPointer: thisClassIndex ofObject: classOop)].
	^self firstFixedField: (self fetchPointer: classNameIndex ofObject: classOop)