translating builtins
generateClass: aNode on: aStream indent: anInteger
	self genCallOf: #fetchClassOf: with: aNode receiver on: aStream