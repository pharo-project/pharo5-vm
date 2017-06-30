failures
expectedFailures
	^(FileDirectory default fileExists: SpurImageTestResource imageNameForTests)
		ifTrue: [#()]
		ifFalse: [self testSelectors]