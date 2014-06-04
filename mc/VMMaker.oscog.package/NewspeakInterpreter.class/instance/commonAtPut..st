indexing primitive support
commonAtPut: stringy
	"This code is called if the receiver responds primitively to at:Put:.
	If this is so, it will be installed in the atPutCache so that subsequent calls of at:
	or  next may be handled immediately in bytecode primitive routines."
	| value index rcvr atIx |
	self initPrimCall.
	rcvr := self stackObjectValue: 2.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := self positive32BitValueOf: (self stackValue: 1).
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	value := self stackTop.

	"NOTE:  The atPut-cache, since it is specific to the non-super response to #at:Put:.
	Therefore we must determine that the message is #at:Put: (not, eg, #basicAt:Put:),
	and that the send is not a super-send, before using the at-cache."
	(messageSelector = (self specialSelector: 17)
	  and: [lkupClass = (self fetchClassOfNonImm: rcvr)])
		ifTrue:
		["OK -- look in the at-cache"
		atIx := (rcvr bitAnd: AtCacheMask) + AtPutBase.  "Index into atPutCache"
		(atCache at: atIx+AtCacheOop) = rcvr ifFalse:
			["Rcvr not in cache.  Install it..."
			self install: rcvr inAtCache: atCache at: atIx string: stringy].
		self successful ifTrue:
			[self commonVariable: rcvr at: index put: value cacheIndex: atIx].
		self successful ifTrue:
			[^ self pop: argumentCount+1 thenPush: value]].

	"The slow but sure way..."
	self initPrimCall.
	stringy ifTrue: [self stObject: rcvr at: index put: (self asciiOfCharacter: value)]
			ifFalse: [self stObject: rcvr at: index put: value].
	self successful ifTrue: [^ self pop: argumentCount+1 thenPush: value].
