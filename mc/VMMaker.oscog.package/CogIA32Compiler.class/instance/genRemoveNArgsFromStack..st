abi
genRemoveNArgsFromStack: n 
	cogit AddCq: n * 4 R: ESP.
	^0