accessing
at: index put: value
	^object at: index + offset + 1 put: value