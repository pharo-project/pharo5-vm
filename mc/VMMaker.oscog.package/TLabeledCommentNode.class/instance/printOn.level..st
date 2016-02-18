printing
printOn: aStream level: level

	self printOptionalLabelOn: aStream.
	comment ifNotNil:
		[aStream nextPut: $".
		 aStream nextPutAll: comment.
		 aStream nextPut: $"]