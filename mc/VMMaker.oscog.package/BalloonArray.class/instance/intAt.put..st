memory access
intAt: index put: value

	value isInteger
		ifFalse: [self error: 'inconsistent values'].
	^ self at: index put: value