class table
knownClassAtIndex: classIndex
	self assert: (classIndex between: 1 and: self classTablePageSize).
	^self fetchPointer: classIndex ofObject: classTableFirstPage