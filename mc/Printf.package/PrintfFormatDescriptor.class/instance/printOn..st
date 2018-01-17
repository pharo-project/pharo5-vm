printing
printOn: aStream
	aStream nextPut: $%.
	flush == #leftFlush ifTrue: [aStream nextPut: $-]