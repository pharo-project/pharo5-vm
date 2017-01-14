object access primitives
primitiveCopyObject
	"Primitive. Copy the state of the receiver from the argument. 
		Fail if receiver and argument are of a different class.
		Fail if the receiver or argument are contexts (because of context-to-stack mapping).
		Fail if receiver and argument have different lengths (for indexable objects).
		Fail if the objects are not in a fit state to be copied (e.g. married contexts and Cogged methods)"
	| rcvr arg length |
	self methodArgumentCount >= 1 ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	arg := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	(objectMemory isImmediate: arg) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].

	(objectMemory fetchClassTagOfNonImm: rcvr)
		~= (objectMemory fetchClassTagOfNonImm: arg) ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].

	(objectMemory isWordsOrBytesNonImm: rcvr)
		ifTrue:
			[length := objectMemory numBytesOf: rcvr.
			((objectMemory formatOf: rcvr) = (objectMemory formatOf: arg)
			  and: [length = (objectMemory numBytesOf: arg)]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument].
			 self mem: (rcvr + objectMemory baseHeaderSize) asVoidPointer
				cp: (arg + objectMemory baseHeaderSize) asVoidPointer
				y: length]
		ifFalse:
			[(self isAppropriateForCopyObject: rcvr) ifFalse:
				[^self primitiveFailFor: PrimErrBadReceiver].
			 length := objectMemory numSlotsOf: rcvr.
			 ((self isAppropriateForCopyObject: arg)
			  and: [length = (objectMemory lengthOf: arg)]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument].
			 0 to: length - 1 do:
				[:i|
				objectMemory
					storePointer: i
					ofObject: rcvr
					withValue: (objectMemory fetchPointer: i ofObject: arg)]].

	"Note: The above could be faster for young receivers but I don't think it'll matter"
	self pop: self methodArgumentCount "pop arg; answer receiver"