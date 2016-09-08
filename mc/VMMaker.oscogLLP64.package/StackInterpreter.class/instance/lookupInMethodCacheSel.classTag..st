method lookup cache
lookupInMethodCacheSel: selector classTag: classTag
	"This method implements a simple method lookup cache.  If an entry for the given
	 selector and classTag is found in the cache, set the values of 'newMethod' and
	 'primitiveFunctionPointer' and answer true. Otherwise, answer false."
	<inline: false>
	^self inlineLookupInMethodCacheSel: selector classTag: classTag