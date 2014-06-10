printing
longPrintOn: aStream

	aStream nextPut: $(.
	self shortPrintOn: aStream.
	aStream space; nextPutAll: self strength printString.
	(self isSatisfied)
		ifTrue:
			[aStream cr; space; space; space.
			 self inputsDo:
				[ :in | aStream nextPutAll: 'v', in printString, ' '].
			aStream nextPutAll: '-> '.
			aStream nextPutAll: 'v', self output printString]
		ifFalse:
			[aStream space; nextPutAll: 'UNSATISFIED'].
	aStream nextPut: $); cr.