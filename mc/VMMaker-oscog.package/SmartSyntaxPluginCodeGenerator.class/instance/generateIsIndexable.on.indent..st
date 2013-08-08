translating builtins
generateIsIndexable: aNode on: aStream indent: anInteger
	self genCallOf: #isIndexable: with: aNode receiver on: aStream