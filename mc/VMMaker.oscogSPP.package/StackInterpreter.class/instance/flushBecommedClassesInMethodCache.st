object memory support
flushBecommedClassesInMethodCache
	"Flush any entries in the cache which refer to a forwarded (becommed) class."
	0 to: MethodCacheSize - 1 by: MethodCacheEntrySize do:
		[:i | | c s |
		c := methodCache at: i + MethodCacheClass.
		s := methodCache at: i + MethodCacheSelector.
		(c ~= 0 and: [s ~= 0
		 and: [objectMemory isForwarded: (objectMemory classOrNilAtIndex: c)]]) ifTrue:
			[methodCache
				at: i + MethodCacheClass put: 0;
				at: i + MethodCacheSelector put: 0]].
	self flushAtCache