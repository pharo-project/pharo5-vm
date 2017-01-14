memory access
intAt: index
	| value |
	value := self at: index.
	value isInteger
		ifFalse: [self error: 'inconsistent values'].
	^ value