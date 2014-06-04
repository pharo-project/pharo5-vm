garbage collection
remapCacheTag: cacheTag
	^(self couldBeObject: cacheTag)
		ifTrue: [objectMemory remap: cacheTag]
		ifFalse: [cacheTag]