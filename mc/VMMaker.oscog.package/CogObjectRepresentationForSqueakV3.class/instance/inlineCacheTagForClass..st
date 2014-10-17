in-line cacheing
inlineCacheTagForClass: classOop
	"Answer the relevant inline cache tag for a class.
	 c.f. inlineCacheTagForInstance:"
	| cci |
	classOop = objectMemory classSmallInteger ifTrue:
		[^objectMemory integerObjectOf: 0]. "the SmallInteger tag"
	(cci :=  objectMemory noShiftCompactClassIndexOfHeader: (objectMemory formatOfClass: classOop)) > 0 ifTrue:
		[^cci].
	^classOop