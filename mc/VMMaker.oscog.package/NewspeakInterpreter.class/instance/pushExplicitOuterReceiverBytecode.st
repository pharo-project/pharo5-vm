stack bytecodes
pushExplicitOuterReceiverBytecode
	"Find the appropriate implicit receiver for outer N"
	|  mClassMixin  litIndex  n anInt |
	<inline: true>
	litIndex := self fetchByte.
	anInt := self literal: litIndex.
	n := self checkedIntegerValueOf: anInt.
	self fetchNextBytecode.
	mClassMixin := self methodClassOf: method.
	self internalPush:(self 
		explicitOuterReceiver: n 
		withObject: receiver 
		withMixin: mClassMixin
		)
