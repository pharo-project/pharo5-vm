memory access
floatAt: index put: value

	value isFloat
		ifFalse: [self error: 'inconsistent values'].
	^ self at: index put: value