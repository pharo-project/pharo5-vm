garbage collection
inlineCacheTagIsYoung: cacheTag
	"Since all cache tags in Spur are class indices none of
	 them are young or have to be updated in a scavenge."
	^false