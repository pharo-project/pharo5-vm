gc - global
coallesceFreeChunk: objOop
	"Attempt to coallesce objOop with the following objects in memory.
	 Answer the possibly changed start of objOop after coallescing."
	| here next |
	here := objOop.
	self assert: (self isRemembered: here) not.
	"Because lastBridge is marked loop below will terminate on reaching lastBridge."
	self assert: (self isMarked: segmentManager lastBridge).
	next := self objectAfter: here limit: endOfMemory.
	[self isMarked: next] whileFalse: "coalescing; rare case"
		[self assert: (self isRemembered: next) not.
		 statCoalesces := statCoalesces + 1.
		 here := self coalesce: here and: next.
		 next := self objectAfter: here limit: endOfMemory].
	^here