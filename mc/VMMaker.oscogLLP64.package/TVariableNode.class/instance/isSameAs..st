comparing
isSameAs: aTParseNode
	^aTParseNode isVariable
	 and: [name = aTParseNode name]