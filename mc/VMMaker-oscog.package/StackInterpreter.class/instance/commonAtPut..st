indexing primitive support
commonAtPut: stringy
	"This code is called if the receiver responds primitively to at:Put:.
	If this is so, it will be installed in the atPutCache so that subsequent calls of at:
	or  next may be handled immediately in bytecode primitive routines."
	| value index rcvr atIx |
	value := self stackTop.
	self initPrimCall.
	rcvr := self stackValue: 2.
	(objectMemory isNonIntegerObject: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := self stackValue: 1.
	"No need to test for large positive integers here.  No object has 1g elements"
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.

	"NOTE:  The atPut-cache, since it is specific to the non-super response to #at:Put:.
	Therefore we must determine that the message is #at:Put: (not, eg, #basicAt:Put:),
	and that the send is not a super-send, before using the at-cache."
	(messageSelector = (self specialSelector: 17)
		and: [lkupClass = (objectMemory fetchClassOfNonInt: rcvr)])
		ifTrue:
		["OK -- look in the at-cache"
		atIx := (rcvr bitAnd: AtCacheMask) + AtPutBase.  "Index into atPutCache"
		(atCache at: atIx+AtCacheOop) = rcvr ifFalse:
			["Rcvr not in cache.  Attempt to install it..."
			(self install: rcvr inAtCache: atCache at: atIx string: stringy) ifFalse:
				[self assert: (objectMemory isContextNonInt: rcvr).
				self initPrimCall.
				^self primitiveContextAtPut]].
		self successful ifTrue:
			[self commonVariable: rcvr at: index put: value cacheIndex: atIx].
		self successful ifTrue:
			[^ self pop: argumentCount+1 thenPush: value]].

	"The slow but sure way..."
	self initPrimCall.
	stringy
		ifTrue: [self stObject: rcvr at: index put: (self asciiOfCharacter: value)]
		ifFalse: [self stObject: rcvr at: index put: value].
	self successful ifTrue:
		[^ self pop: argumentCount+1 thenPush: value]