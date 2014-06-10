translating builtins
generateAsCharPtr: aNode on: aStream indent: anInteger
	self generateCoerceToPtr: 'char *' fromObject: aNode receiver on: aStream