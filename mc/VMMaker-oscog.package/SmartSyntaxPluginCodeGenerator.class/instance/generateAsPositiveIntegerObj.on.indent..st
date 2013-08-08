translating builtins
generateAsPositiveIntegerObj: aNode on: aStream indent: anInteger
	self genCallOf: #positive32BitIntegerFor: with: aNode receiver on: aStream