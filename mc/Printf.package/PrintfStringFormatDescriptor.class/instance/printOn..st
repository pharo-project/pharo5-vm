printing
printOn: aStream
	super printOn: aStream.
	self printWidthOn: aStream.
	aStream nextPut: $s