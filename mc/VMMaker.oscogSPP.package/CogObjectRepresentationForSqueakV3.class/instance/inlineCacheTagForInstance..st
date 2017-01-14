in-line cacheing
inlineCacheTagForInstance: oop
	"Answer the relevant inline cache tag for an instance.
	 c.f. getInlineCacheClassTagFrom:into: & inlineCacheTagForClass:"
	| cci |
	(objectMemory isIntegerObject: oop) ifTrue:
		[^objectMemory integerObjectOf: 0]. "the SmallInteger tag"
	(cci :=  objectMemory noShiftCompactClassIndexOf: oop) > 0 ifTrue:
		[^cci].
	^(objectMemory classHeader: oop) bitAnd: AllButTypeMask