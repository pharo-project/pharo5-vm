stack bytecodes
pushImplicitReceiverBytecode
	"This bytecode is used to implement outer sends in NS2/NS3. The
	 bytecode takes as an argument the literal offset of a selector. It
	 effectively finds the nearest lexically-enclosing implementation of
	 that selector by searching up the static chain of the receiver,
	 starting at the current method."
	| selector |
	selector := self literal: self fetchByte.
	self fetchNextBytecode.
	self internalPush: (self
						implicitReceiverFor: self receiver
						mixin: (self methodClassOf: method)
						implementing: selector)