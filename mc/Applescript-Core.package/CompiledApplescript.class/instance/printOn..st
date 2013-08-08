printing
printOn: aStream
	self printNameOn: aStream.
	aStream nextPutAll: ' ('; print: self size; nextPutAll: ' bytes)'