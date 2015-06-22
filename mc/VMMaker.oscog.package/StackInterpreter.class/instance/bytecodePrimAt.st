common selector sends
bytecodePrimAt
	"BytecodePrimAt will only succeed if the receiver is in the atCache.
	 Otherwise it will fail so that the more general primitiveAt will put it in the
	 cache after validating that message lookup results in a primitive response.
	 Override to insert in the at: cache here.  This is necessary since once there
	 is a compiled at: primitive method (which doesn't use the at: cache) the only
	 way something can get installed in the atCache is here."
	| index rcvr result atIx |
	index := self internalStackTop.
	rcvr := self internalStackValue: 1.
	((objectMemory isNonImmediate: rcvr)
	 and: [objectMemory isIntegerObject: index]) ifTrue:
		[atIx := rcvr bitAnd: AtCacheMask.  "Index into atCache = 4N, for N = 0 ... 7"
		(atCache at: atIx+AtCacheOop) ~= rcvr ifTrue:
			[lkupClassTag := objectMemory fetchClassTagOfNonImm: rcvr.
			 messageSelector := self specialSelector: 16.
			 (self lookupInMethodCacheSel: messageSelector classTag: lkupClassTag) ifFalse:
				[argumentCount := 1.
				 ^self commonSendOrdinary].
			 primitiveFunctionPointer == #primitiveAt
				ifTrue: [self install: rcvr inAtCache: atCache at: atIx string: false]
				ifFalse:
					[primitiveFunctionPointer == #primitiveStringAt
						ifTrue: [self install: rcvr inAtCache: atCache at: atIx string: true]
						ifFalse:
							[argumentCount := 1.
							 ^self commonSendOrdinary]]].
		 self successful ifTrue:
			[result := self commonVariable: rcvr at: (objectMemory integerValueOf: index) cacheIndex: atIx].
		 self successful ifTrue:
			[self fetchNextBytecode.
			 ^self internalPop: 2 thenPush: result].
		 self initPrimCall].

	messageSelector := self specialSelector: 16.
	argumentCount := 1.
	self normalSend