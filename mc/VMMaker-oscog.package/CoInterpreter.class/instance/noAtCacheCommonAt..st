indexing primitive support
noAtCacheCommonAt: stringy
	"This code is called if the receiver responds primitively to at:.
	 The cogit can implement at: & at:put: quickly in machine code, and needs a backup
	 that provides error codes.  But it does not want the at cache so it does not have to
	 waste time assigning messageSelector and lkupClass."
	| index rcvr result |
	self initPrimCall.
	rcvr := self stackValue: 1.
	(objectMemory isNonIntegerObject: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := self stackTop.
	"No need to test for large positive integers here.  No object has 1g elements"
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	result := self stObject: rcvr at: index.
	self successful ifTrue:
		[stringy ifTrue: [result := self characterForAscii: (objectMemory integerValueOf: result)].
		^ self pop: argumentCount+1 thenPush: result]