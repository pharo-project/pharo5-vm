printing
printOn: aStream
	super printOn: aStream.
	padding == $0 ifTrue: [aStream nextPut: $0].
	radix ifTrue: [aStream nextPut: $#].
	space ifTrue: [aStream nextPut: $ ].
	self printWidthOn: aStream.
	aStream nextPut: operator