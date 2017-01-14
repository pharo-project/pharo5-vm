accessing
at: index put: val
	self assert: (index between: 1 and: self size).
	unitSize = 1 ifTrue: [^ interpreter storeByte: index - 1 ofObject: oop withValue: val].
	unitSize = 2 ifTrue: [^ interpreter storeShort16: index - 1 ofObject: oop withValue: val].
	unitSize = 4 ifTrue: [^ interpreter storeLong32: index - 1 ofObject: oop withValue: val].
	unitSize = 8 ifTrue: [^ interpreter storeLong64: index - 1 ofObject: oop withValue: val].
	self halt: 'Can''t handle unitSize ', unitSize printString