translating builtins
generateAsCInt: aNode on: aStream indent: anInteger
	self genCallOf: #integerValueOf: with: aNode receiver on: aStream