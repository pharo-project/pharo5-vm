simulation stack
ssPushConstant: literal
	super ssPushConstant: literal.
	self ssTop liveRegister: NoReg.
	^0