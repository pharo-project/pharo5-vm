object access primitives
primitiveCopyObject
	"Primitive. Copy the state of the receiver from the argument. 
		Fail if receiver and argument are of a different class. 
		Fail if the receiver or argument are non-pointer objects.
		Fail if receiver and argument have different lengths (for indexable objects).
	"
	| rcvr arg length |
	self methodArgumentCount = 1 ifFalse:
		[^self primitiveFail].
	arg := self stackObjectValue: 0.
	rcvr := self stackObjectValue: 1.

	self failed ifTrue:[^nil].
	(objectMemory isPointers: rcvr) ifFalse:
		[^self primitiveFail].
	(objectMemory fetchClassOfNonImm: rcvr) = (objectMemory fetchClassOfNonImm: arg) ifFalse:
		[^self primitiveFail].
	length := objectMemory lengthOf: rcvr.
	length = (objectMemory lengthOf: arg) ifFalse:
		[^self primitiveFail].
	
	"Now copy the elements"
	0 to: length-1 do:[:i|
		objectMemory storePointer: i ofObject: rcvr withValue: (objectMemory fetchPointer: i ofObject: arg)].

	"Note: The above could be faster for young receivers but I don't think it'll matter"
	self pop: 1. "pop arg; answer receiver"
