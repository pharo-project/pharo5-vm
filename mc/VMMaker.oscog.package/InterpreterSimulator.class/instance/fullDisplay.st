I/O primitives
fullDisplay
	| t |
	displayForm == nil ifTrue: [^ self].
	t := successFlag.  successFlag := true.
	self displayBitsOf: (self splObj: TheDisplay) Left: 0 Top: 0 Right: displayForm width Bottom: displayForm height.
	successFlag := t