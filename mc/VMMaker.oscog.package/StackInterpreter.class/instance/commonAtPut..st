indexing primitive support
commonAtPut: stringy
	"This code is called if the receiver responds primitively to at:Put:.
	 N.B. this does *not* use the at cache, instead inlining stObject:at:put:.
	 Using the at cache here would require that callers set messageSelector
	 and lkupClass and that is onerous and error-prone, and in any case,
	 inlining produces much better performance than using the at cache here."
	| value index rcvr |
	<inline: true> "to get it inlined in primitiveAtPut and primitiveStringAtPut"
	self initPrimCall.
	rcvr := self stackValue: 2.
	index := self stackValue: 1.
	value := self stackTop.
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	"No need to test for large positive integers here.  No object has 1g elements"
	((objectMemory isNonIntegerObject: index)
	 or: [argumentCount > 2 "e.g. object:basicAt:put:"
		 and: [objectMemory isForwarded: rcvr]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory isObjImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	index := objectMemory integerValueOf: index.
	stringy
		ifTrue: [self stObject: rcvr at: index put: (self asciiOfCharacter: value)]
		ifFalse: [self stObject: rcvr at: index put: value].
	self successful ifTrue:
		[self pop: argumentCount+1 thenPush: value]