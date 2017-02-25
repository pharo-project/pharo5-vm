translating builtins
generateAsCDouble: aNode on: aStream indent: anInteger
	self genCallOf: #floatValueOf: with: aNode receiver on: aStream