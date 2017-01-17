translating builtins
generateFieldPut: aNode on: aStream indent: anInteger
	self genCallOf: #storePointer:ofObject:withValue:
		with: aNode args first
		with: aNode receiver
		with: aNode args second
		on: aStream