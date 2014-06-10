accessing
at: index put: value
	^writeBlock value: object value: index + offset + 1 value: value