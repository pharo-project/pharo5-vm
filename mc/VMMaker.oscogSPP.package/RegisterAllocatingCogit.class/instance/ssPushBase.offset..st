simulation stack
ssPushBase: reg offset: offset
	super ssPushBase: reg offset: offset.
	self ssTop liveRegister: NoReg.
	^0