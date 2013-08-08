array and stream primitives
primitiveNextPut
	"PrimitiveNextPut will succeed only if the stream's array is in the atPutCache.
	Otherwise failure will lead to proper message lookup of at:put: and
	subsequent installation in the cache if appropriate."
	| value stream index limit array atIx |
	value := self stackTop.
	stream := self stackValue: 1.
	((self isPointers: stream)
		and: [(self lengthOf: stream) >= (StreamReadLimitIndex + 1)])
		ifFalse: [^ self primitiveFail].

	array := self fetchPointer: StreamArrayIndex ofObject: stream.
	index := self fetchInteger: StreamIndexIndex ofObject: stream.
	limit := self fetchInteger: StreamReadLimitIndex ofObject: stream.
	atIx := (array bitAnd: AtCacheMask) + AtPutBase.
	(index < limit
	 and: [(atCache at: atIx+AtCacheOop) = array]) ifFalse:
		[^self primitiveFail].
	((self isOopImmutable: stream)
	 or: [self isOopImmutable: array]) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].

	"OK -- its not at end, and the array is in the cache"
	index := index + 1.
	self commonVariable: array at: index put: value cacheIndex: atIx.
	self successful ifTrue:
		[self storeInteger: StreamIndexIndex ofObject: stream withValue: index.
		^ self pop: 2 thenPush: value].
