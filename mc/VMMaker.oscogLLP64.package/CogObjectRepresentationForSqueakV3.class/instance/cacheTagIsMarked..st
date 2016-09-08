garbage collection
cacheTagIsMarked: cacheTag
	"Answer if the cacheTag is not unmarked, i.e. answer true for compact
	 class indices and immediates; only answer false for unmarked objects"
	(self couldBeObject: cacheTag) ifFalse: [^true].
	self assert: (objectMemory addressCouldBeObj: cacheTag).
	^objectMemory isMarked: cacheTag