comparing
isSameAs: aTParseNode
	^aTParseNode isConstant
	 and: [value class == aTParseNode value class
	 and: [value = aTParseNode value]]