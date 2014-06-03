translating builtins
generateStAtPut: aNode on: aStream indent: anInteger
	self genCallOf: #stObject:at:put:
		with: aNode receiver
		with: aNode args first
		with: aNode args second
		on: aStream