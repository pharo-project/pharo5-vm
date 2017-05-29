abi
genRemoveNArgsFromStack: n
	<inline: true>
	n = 0 ifFalse: [cogit AddCq: n * 4 R: ESP].
	^0