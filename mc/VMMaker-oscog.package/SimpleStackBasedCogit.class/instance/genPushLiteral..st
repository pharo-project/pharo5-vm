bytecode generators
genPushLiteral: literal
	self annotate: (self PushCw: literal) objRef: literal.
	^0