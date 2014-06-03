translating builtins
generateStSize: aNode on: aStream indent: anInteger
	self genCallOf: #stSizeOf: with: aNode receiver on: aStream