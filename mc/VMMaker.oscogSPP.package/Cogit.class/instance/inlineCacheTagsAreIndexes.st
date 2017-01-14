in-line cacheing
inlineCacheTagsAreIndexes
	"The Cogit always generates 32-bit inline caches.  This implies that in 64-bits there is no room
	 in an unlinked inline cache for a selector oop.  Instead it contains a signed 32-bit index, positive
	 for selectors in a method's literal frame and negative for selectors in the specialSelectorsOop.
	 And it implies that linked inline cache entries contain class indices, not class oops."
	<inline: true>
	^objectMemory wordSize = 8