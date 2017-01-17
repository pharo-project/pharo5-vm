I/O primitives
fullDisplay
	| primFailCodeValue |
	displayForm == nil ifTrue: [^ self].
	primFailCodeValue := primFailCode.
	self initPrimCall.
	self displayBitsOf: (objectMemory splObj: TheDisplay) Left: 0 Top: 0 Right: displayForm width Bottom: displayForm height.
	primFailCode := primFailCodeValue