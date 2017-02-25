initialize-release
objectMemory: anObjectMemory at: anAddress array: cacheArray functionPointerIndex: fpIndex entrySize: wordsPerCacheEntry
	self objectMemory: anObjectMemory
		at: anAddress - anObjectMemory wordSize. "implicit -1 for indices in at:[put:]; the MethodCache is one-relative"
	methodCacheArray := cacheArray.
	functionPointerIndex := fpIndex - 1.
	entrySize := wordsPerCacheEntry