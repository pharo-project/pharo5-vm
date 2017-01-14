method lookup cache
flushMethodCacheFrom: memStart to: memEnd 
	"Flush entries in the method cache only if the oop address is within the given memory range. 
	This reduces overagressive cache clearing. Note the AtCache is fully flushed, 70% of the time 
	cache entries live in newspace, new objects die young"
	| probe |
	probe := 0.
	1 to: MethodCacheEntries do: [:i | 
			(methodCache at: probe + MethodCacheSelector) = 0
				ifFalse: [((((self oop: (methodCache at: probe + MethodCacheSelector) isGreaterThanOrEqualTo: memStart)
										and: [self oop: (methodCache at: probe + MethodCacheSelector) isLessThan: memEnd])
									or: [(self oop: (methodCache at: probe + MethodCacheClass) isGreaterThanOrEqualTo: memStart)
											and: [self oop: (methodCache at: probe + MethodCacheClass) isLessThan: memEnd]])
								or: [(self oop: (methodCache at: probe + MethodCacheMethod) isGreaterThanOrEqualTo: memStart)
										and: [self oop: (methodCache at: probe + MethodCacheMethod) isLessThan: memEnd]])
						ifTrue: [methodCache at: probe + MethodCacheSelector put: 0]].
			probe := probe + MethodCacheEntrySize].
	1 to: AtCacheTotalSize do: [:i | atCache at: i put: 0]