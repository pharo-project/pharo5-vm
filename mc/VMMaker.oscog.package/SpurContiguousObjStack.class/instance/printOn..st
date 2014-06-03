printing
printOn: aStream
	<doNotGenerate>
	super printOn: aStream.
	top ifNotNil:
		[aStream nextPutAll: ' top: '; nextPutAll: top hex]