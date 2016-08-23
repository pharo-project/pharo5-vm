translating builtins
generateAsSmallIntegerObj: aNode on: aStream indent: anInteger
	self genCallOf: #integerObjectOf: with: aNode receiver on: aStream