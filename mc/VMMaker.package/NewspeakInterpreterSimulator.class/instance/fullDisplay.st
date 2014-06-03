I/O primitives
fullDisplay
	| t |
	displayForm == nil ifTrue: [^ self].
	t := primFailCode.  primFailCode := 0.
	self displayBitsOf: (self splObj: TheDisplay) Left: 0 Top: 0 Right: displayForm width Bottom: displayForm height.
	primFailCode := t