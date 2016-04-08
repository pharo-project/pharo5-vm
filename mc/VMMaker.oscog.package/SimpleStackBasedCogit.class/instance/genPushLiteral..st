bytecode generator support
genPushLiteral: literal
	self genPushConstant: literal.
	^0