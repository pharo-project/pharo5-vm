printing
printOn: aStream
	<doNotGenerate>
	super printOn: aStream.
	first ifNotNil:
		[aStream nextPutAll: ' first: '; nextPutAll: first hex].
	last ifNotNil:
		[aStream nextPutAll: ' last: '; nextPutAll: last hex]