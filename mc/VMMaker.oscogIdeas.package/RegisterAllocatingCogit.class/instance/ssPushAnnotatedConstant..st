simulation stack
ssPushAnnotatedConstant: literal
	super ssPushAnnotatedConstant: literal.
	self ssTop liveRegister: NoReg.
	^0