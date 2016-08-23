enumerating
detect: aBlock
	^self detect: aBlock ifNone: [self error: 'Node is not in the tree']