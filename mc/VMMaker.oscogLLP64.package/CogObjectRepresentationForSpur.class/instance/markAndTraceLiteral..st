garbage collection
markAndTraceLiteral: literal
	(self couldBeObject: literal) ifTrue:
		[self assert: (objectMemory addressCouldBeObj: literal).
		 objectMemory markAndTrace: literal]