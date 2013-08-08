translating builtins
generateIsIntegerValue: aNode on: aStream indent: anInteger
	self genCallOf: #isIntegerValue: with: aNode receiver on: aStream