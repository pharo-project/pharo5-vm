translating builtins
generateIsIntegerOop: aNode on: aStream indent: anInteger
	self genCallOf: #isIntegerObject: with: aNode receiver on: aStream