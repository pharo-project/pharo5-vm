in-line cacheing
inlineCacheTagForInstance: oop
	"c.f. getInlineCacheClassTagFrom:into:"
	(objectMemory isImmediate: oop) ifTrue:
		[(objectMemory isIntegerObject: oop) ifTrue:
			[^objectMemory integerObjectOf: 0]. "the SmallInteger tag"
		 ^oop bitAnd: objectMemory tagMask]. "the other tags"
	^objectMemory classIndexOf: oop