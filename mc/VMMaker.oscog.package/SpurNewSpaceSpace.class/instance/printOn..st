printing
printOn: aStream
	<doNotGenerate>
	super printOn: aStream.
	(start notNil and: [limit notNil]) ifTrue:
		[aStream nextPutAll: ' start: '; nextPutAll: start hex; nextPutAll: ' limit: '; nextPutAll: limit hex]