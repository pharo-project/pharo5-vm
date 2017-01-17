in-line cacheing
inlineCacheTagForClass: classOop
	"Answer the relevant inline cache tag for a class.
	 c.f. inlineCacheTagForInstance:"
	| hash |
	hash := objectMemory classTagForClass: classOop.
	^hash <= objectMemory tagMask
		ifTrue: [hash bitAnd: 1]
		ifFalse: [hash]