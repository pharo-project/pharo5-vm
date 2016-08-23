comparing
isSameAs: aTParseNode
	^self class == aTParseNode class
	  and: [value class == aTParseNode value class
	  and: [value = aTParseNode value
	  and: [name = aTParseNode nameOrValue]]]