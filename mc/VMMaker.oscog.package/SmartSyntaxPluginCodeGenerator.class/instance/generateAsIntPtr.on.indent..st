translating builtins
generateAsIntPtr: aNode on: aStream indent: anInteger
	self generateCoerceToPtr: 'int *' fromObject: aNode receiver on: aStream