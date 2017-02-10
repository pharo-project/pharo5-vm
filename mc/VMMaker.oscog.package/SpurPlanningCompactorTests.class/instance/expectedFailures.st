failures
expectedFailures
	^(FileDirectory default fileExists: self class imageNameForTests)
		ifTrue: [#()]
		ifFalse: [self testSelectors]