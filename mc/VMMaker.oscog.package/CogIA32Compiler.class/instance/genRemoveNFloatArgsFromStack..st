abi
genRemoveNFloatArgsFromStack: n 
	n > 0 ifTrue: [cogit AddCq: n * 8 R: ESP].
	^0