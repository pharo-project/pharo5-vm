simulation stack
ssPushRegister: reg
	super ssPushRegister: reg.
	self ssTop liveRegister: NoReg.
	^0