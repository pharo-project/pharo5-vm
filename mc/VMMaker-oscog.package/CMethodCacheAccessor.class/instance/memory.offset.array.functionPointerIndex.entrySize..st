initialize-release
memory: anObject offset: baseIndex array: cacheArray functionPointerIndex: fpIndex entrySize: esz
	object := anObject.
	offset := baseIndex.
	methodCacheArray := cacheArray.
	functionPointerIndex := fpIndex - 1.
	entrySize := esz