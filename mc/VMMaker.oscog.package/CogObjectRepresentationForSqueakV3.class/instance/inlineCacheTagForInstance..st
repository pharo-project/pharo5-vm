in-line cacheing
inlineCacheTagForInstance: oop
	"c.f. getInlineCacheClassTagFrom:into:"
	| cci |
	(objectMemory isIntegerObject: oop) ifTrue:
		[^objectMemory integerObjectOf: 0]. "the SmallInteger tag"
	(cci :=  objectMemory compactClassIndexOf: oop) > 0 ifTrue:
		[^cci << ShiftForWord].
	^(objectMemory classHeader: oop) bitAnd: AllButTypeMask