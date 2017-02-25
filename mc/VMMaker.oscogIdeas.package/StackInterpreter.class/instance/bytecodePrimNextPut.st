common selector sends
bytecodePrimNextPut
	messageSelector := self specialSelector: 20.
	argumentCount := self specialSelectorNumArgs: 20.
	self normalSend.