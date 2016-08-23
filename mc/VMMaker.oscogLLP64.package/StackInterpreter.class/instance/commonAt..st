indexing primitive support
commonAt: stringy
	"This code is called if the receiver responds primitively to at:.
	 N.B. this does *not* use the at cache, instead inlining stObject:at:.
	 Using the at cache here would require that callers set messageSelector
	 and lkupClass and that is onerous and error-prone, and in any case,
	 inlining produces much better performance than using the at cache here."
	| index rcvr result |
	<inline: true> "to get it inlined in primitiveAt and primitiveStringAt"
	self initPrimCall.
	rcvr := self stackValue: 1.
	index := self stackTop.
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	"No need to test for large positive integers here.  No object has 1g elements"
	((objectMemory isNonIntegerObject: index)
	 or: [argumentCount > 1 "e.g. object:basicAt:"
		 and: [objectMemory isForwarded: rcvr]]) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	result := self stObject: rcvr at: index.
	self successful ifTrue:
		[stringy ifTrue:
			[(objectMemory isInRangeCharacterCode: result) ifFalse:
				[^self primitiveFailFor: PrimErrBadReceiver].
			 result := self characterForAscii: (objectMemory integerValueOf: result)].
		 self pop: argumentCount+1 thenPush: result]