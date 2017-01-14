translating builtins
generateIsMemberOf: aNode on: aStream indent: anInteger
	self genCallOf: #is:MemberOf: with: aNode receiver with: aNode args first on: aStream