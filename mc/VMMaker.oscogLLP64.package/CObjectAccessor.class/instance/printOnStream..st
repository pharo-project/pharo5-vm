printing
printOnStream: aStream
	super printOnStream: aStream.
	aStream
		print:' on: ';
		write: object.