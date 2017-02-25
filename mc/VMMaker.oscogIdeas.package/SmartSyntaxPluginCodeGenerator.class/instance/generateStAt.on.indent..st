translating builtins
generateStAt: aNode on: aStream indent: anInteger
	self genCallOf: #stObject:at: with: aNode receiver with: aNode args first on: aStream