indexing primitive support
noAtCacheCommonAtPut: stringy
	"This code is called if the receiver responds primitively to at:Put:.
	 The cogit can implement at: & at:put: quickly in machine code, and needs a backup
	 that provides error codes.  But it does not want the at cache so it does not have to
	 waste time assigning messageSelector and lkupClass."
	| value index rcvr |
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
	stringy
		ifTrue: [self stObject: rcvr at: index put: (self asciiOfCharacter: value)]
		ifFalse: [self stObject: rcvr at: index put: value].
	self successful ifTrue:
		[^ self pop: argumentCount+1 thenPush: value]