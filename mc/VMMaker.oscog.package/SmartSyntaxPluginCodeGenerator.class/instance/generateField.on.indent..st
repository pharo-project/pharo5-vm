translating builtins
generateField: aNode on: aStream indent: anInteger
	self genCallOf: #fetchPointer:ofObject: with: aNode args first with: aNode receiver on: aStream