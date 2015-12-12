in-line cacheing
inlineCacheValueForSelector: selector in: aCogMethod at: mcpc
	"Answer the value to put in an inline-cache that is being loaded with the selector.
	 Usually this is simply the selector, but in 64-bits the cache is only 32-bits wide
	 and so the cache is loaded with the index of the selector."
	<inline: true>
	^objectMemory wordSize < 8
		ifTrue: [selector]
		ifFalse: [self indexForSelector: selector in: aCogMethod at: mcpc]