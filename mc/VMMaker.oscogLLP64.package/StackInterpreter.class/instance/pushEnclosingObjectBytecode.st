stack bytecodes
pushEnclosingObjectBytecode
	"Find the enclosing object at level N"
	| litIndex  n anIntOop |
	<inline: true>
	litIndex := self fetchByte.
	anIntOop := self literal: litIndex.
	n := (objectMemory isIntegerObject: anIntOop)
			ifTrue: [objectMemory integerValueOf: anIntOop]
			ifFalse: [0].
	self fetchNextBytecode.
	self internalPush:(self 
						enclosingObjectAt: n 
						withObject: self receiver 
						withMixin: (self methodClassOf: method))