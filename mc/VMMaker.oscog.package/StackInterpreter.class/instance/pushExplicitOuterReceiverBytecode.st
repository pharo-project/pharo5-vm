stack bytecodes
pushExplicitOuterReceiverBytecode
	"Find the appropriate implicit receiver for outer N"
	| litIndex  n anIntOop |
	<inline: true>
	litIndex := self fetchByte.
	anIntOop := self literal: litIndex.
	n := (objectMemory isIntegerObject: anIntOop)
			ifTrue: [objectMemory integerValueOf: anIntOop]
			ifFalse: [0].
	self fetchNextBytecode.
	self internalPush:(self 
						explicitOuterReceiver: n 
						withObject: self receiver 
						withMixin: (self methodClassOf: method))