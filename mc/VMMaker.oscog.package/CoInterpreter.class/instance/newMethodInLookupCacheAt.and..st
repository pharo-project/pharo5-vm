method lookup cache
newMethodInLookupCacheAt: selector and: classTag
	"Answer if classTag x messageSelector => newMethod is in the lookup cache.
	 This is for assert checking to check that open PICs find entries."
	| probe hash |
	<inline: false>
	hash := objectMemory methodCacheHashOf: selector with: classTag.

	0 to: CacheProbeMax-1 do:
		[:p |
		probe := (hash >> p) bitAnd: MethodCacheMask.
		((methodCache at: probe + MethodCacheSelector) = selector
		 and: [(methodCache at: probe + MethodCacheClass) = classTag
		 and: [(methodCache at: probe + MethodCacheMethod) = newMethod]]) ifTrue:
			[^true]].

	^false