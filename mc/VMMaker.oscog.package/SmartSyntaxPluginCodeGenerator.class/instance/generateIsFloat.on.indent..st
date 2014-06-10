translating builtins
generateIsFloat: aNode on: aStream indent: anInteger
	self genCallOf: #isFloatObject: with: aNode receiver on: aStream