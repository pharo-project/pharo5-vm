common selector sends
bytecodePrimAtPut
	"BytecodePrimAtPut will only succeed if the receiver is in the atCache.
	Otherwise it will fail so that the more general primitiveAtPut will put it in the
	cache after validating that message lookup results in a primitive response."
	| index rcvr atIx value |
	value := self internalStackTop.
	index := self internalStackValue: 1.
	rcvr := self internalStackValue: 2.
	((objectMemory isIntegerObject: rcvr) not
	 and: [objectMemory isIntegerObject: index]) ifTrue:
		[atIx := (rcvr bitAnd: AtCacheMask) + AtPutBase.  "Index into atPutCache"
		 (atCache at: atIx+AtCacheOop) = rcvr ifTrue:
			[self commonVariable: rcvr at: (objectMemory integerValueOf: index) put: value cacheIndex: atIx.
			 self successful ifTrue:
				[self fetchNextBytecode.
				 ^self internalPop: 3 thenPush: value].
			 self initPrimCall]].

	messageSelector := self specialSelector: 17.
	argumentCount := 2.
	self normalSend