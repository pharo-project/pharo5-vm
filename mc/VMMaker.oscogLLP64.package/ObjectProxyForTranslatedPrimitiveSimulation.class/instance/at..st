accessing
at: index
	self assert: (index between: 1 and: self size).
	unitSize = 1 ifTrue: [^interpreter fetchByte: index - 1 ofObject: oop].
	unitSize = 2 ifTrue: [^interpreter fetchShort16: index - 1 ofObject: oop].
	unitSize = 4 ifTrue: [^interpreter fetchLong32: index - 1 ofObject: oop].
	unitSize = 8 ifTrue: [^interpreter fetchLong64: index - 1 ofObject: oop].
	self halt: 'Can''t handle unitSize ', unitSize printString