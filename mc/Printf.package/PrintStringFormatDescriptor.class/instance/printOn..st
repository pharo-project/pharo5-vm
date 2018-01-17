printing
printOn: aStream
	aStream nextPut: $%.
	flush == #leftFlush ifTrue: [aStream nextPut: $-].
	self printWidthOn: aStream.
	aStream nextPut: $p