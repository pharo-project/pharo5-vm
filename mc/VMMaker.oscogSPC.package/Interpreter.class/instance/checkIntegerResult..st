arithmetic primitive support
checkIntegerResult: integerResult
	(successFlag and: [self isIntegerValue: integerResult])
		ifTrue: [self pushInteger: integerResult]
		ifFalse: [self unPop: 2]