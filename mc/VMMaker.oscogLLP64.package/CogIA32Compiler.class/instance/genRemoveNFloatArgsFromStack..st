abi
genRemoveNFloatArgsFromStack: n 
	cogit AddCq: n * 8 R: ESP.
	^0