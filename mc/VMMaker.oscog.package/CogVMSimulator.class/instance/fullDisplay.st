I/O primitives
fullDisplay
	| primFailCodeValue |
	displayForm ifNil: [^self].
	primFailCodeValue := primFailCode.
	self initPrimCall.
	self updateDisplayLeft: 0 Top: 0 Right: displayWidth Bottom: displayHeight.
	primFailCode := primFailCodeValue