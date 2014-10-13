stack bytecodes
pushEnclosingObjectBytecode
	"Find the enclosing object at level N"
	|  mClassMixin  litIndex  anInt |
	<inline: true>
	litIndex := self fetchByte.
	anInt := self literal: litIndex.
	self fetchNextBytecode.
	mClassMixin := self methodClassOf: method.
	self internalPush: (self 
						enclosingObjectAt: (self integerValueOf: anInt) 
						withObject: receiver 
						withMixin: mClassMixin)
