translating builtins
generateIsPointers: aNode on: aStream indent: anInteger
	self genCallOf: #isPointers: with: aNode receiver on: aStream