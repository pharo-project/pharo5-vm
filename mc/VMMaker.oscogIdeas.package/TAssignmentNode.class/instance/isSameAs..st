testing
isSameAs: aTParseNode
	^aTParseNode isAssignment
	 and: [(variable isSameAs: aTParseNode variable)
	 and: [expression isSameAs: aTParseNode expression]]