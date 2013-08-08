garbage collection
markAndTraceLiteralIfYoung: literal
	((self couldBeObject: literal)
	 and: [objectMemory isYoung: literal]) ifTrue:
		[self assert: (objectMemory addressCouldBeObj: literal).
		 objectMemory markAndTrace: literal]