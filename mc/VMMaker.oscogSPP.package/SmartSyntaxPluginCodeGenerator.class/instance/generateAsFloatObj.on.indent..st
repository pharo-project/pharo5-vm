translating builtins
generateAsFloatObj: aNode on: aStream indent: anInteger
	self genCallOf: #floatObjectOf: with: aNode receiver on: aStream