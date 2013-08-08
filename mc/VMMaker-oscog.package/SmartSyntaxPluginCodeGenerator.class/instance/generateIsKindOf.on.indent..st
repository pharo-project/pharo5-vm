translating builtins
generateIsKindOf: aNode on: aStream indent: anInteger
	self genCallOf: #is:KindOf: with: aNode receiver with: aNode args first on: aStream