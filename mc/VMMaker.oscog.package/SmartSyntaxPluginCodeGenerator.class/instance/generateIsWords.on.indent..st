translating builtins
generateIsWords: aNode on: aStream indent: anInteger
	self genCallOf: #isWords: with: aNode receiver on: aStream