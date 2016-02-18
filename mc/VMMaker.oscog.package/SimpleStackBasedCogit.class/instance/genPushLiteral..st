bytecode generator support
genPushLiteral: literal
	self annotate: (self PushCw: literal) objRef: literal.
	^0