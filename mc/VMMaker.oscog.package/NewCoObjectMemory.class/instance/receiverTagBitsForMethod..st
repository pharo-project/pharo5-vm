cog jit support
receiverTagBitsForMethod: aMethodObj
	"Answer the tag bits for the receiver based on the method's methodClass, if any."
	<api>
	^(coInterpreter methodClassOf: aMethodObj) = self classSmallInteger
		ifTrue: [self smallIntegerTag]
		ifFalse: [0]