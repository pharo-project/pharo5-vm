translating builtins
generateIsWordsOrBytes: aNode on: aStream indent: anInteger
	self genCallOf: #isWordsOrBytes: with: aNode receiver on: aStream