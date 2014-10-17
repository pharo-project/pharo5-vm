in-line cacheing
classForInlineCacheTag: inlineCacheTag
	(objectMemory isIntegerObject: inlineCacheTag) ifTrue:
		[^objectMemory classSmallInteger].
	(self couldBeObject: inlineCacheTag) ifTrue:
		[^inlineCacheTag].
	^objectMemory compactClassAt: inlineCacheTag >> objectMemory compactClassFieldLSB