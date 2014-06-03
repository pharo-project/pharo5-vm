indexing primitive support
commonAtPut: stringy
	"This code is called if the receiver responds primitively to at:Put:.
	 N.B. this does *not* use the at cache, instead inlining stObject:at:put:.
	 Using the at cache here would require that callers set messageSelector
	 and lkupClass and that is onerous and error-prone, and in any case,
	 inlining produces much better performance than using the at cache here."
	| value index rcvr |
	<inline: true> "to get it inlined in primitiveAtPut and primitiveStringAtPut"
	value := self stackTop.
	self initPrimCall.
	rcvr := self stackValue: 2.
	(objectMemory isNonImmediate: rcvr) ifFalse:
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
		[self pop: argumentCount+1 thenPush: value]