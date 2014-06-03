indexing primitive support
commonAt: stringy
	"This code is called if the receiver responds primitively to at:.
	If this is so, it will be installed in the atCache so that subsequent calls of at:
	or next may be handled immediately in bytecode primitive routines."
	| index rcvr atIx result |
	self initPrimCall.
	rcvr := self stackObjectValue: 1.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := self positive32BitValueOf: self stackTop.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].

	"NOTE:  The at-cache, since it is specific to the non-super response to #at:.
	Therefore we must determine that the message is #at: (not, eg, #basicAt:),
	and that the send is not a super-send, before using the at-cache."
	(messageSelector = (self specialSelector: 16)
		and: [lkupClass = (self fetchClassOfNonImm: rcvr)])
		ifTrue:
		["OK -- look in the at-cache"
		atIx := rcvr bitAnd: AtCacheMask.  "Index into atCache = 4N, for N = 0 ... 7"
		(atCache at: atIx+AtCacheOop) = rcvr ifFalse:
			["Rcvr not in cache.  Install it..."
			self install: rcvr inAtCache: atCache at: atIx string: stringy].
		self successful ifTrue:
			[result := self commonVariable: rcvr at: index cacheIndex: atIx].
		self successful ifTrue:
			[^ self pop: argumentCount+1 thenPush: result]].

	"The slow but sure way..."
	self initPrimCall.
	result := self stObject: rcvr at: index.
	self successful ifTrue:
		[stringy ifTrue: [result := self characterForAscii: (self integerValueOf: result)].
		^ self pop: argumentCount+1 thenPush: result]