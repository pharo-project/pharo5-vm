asOop:/asValue:
generateCoerceToPtr: aString fromObject: aNode on: aStream
	"This code assumes no named instance variables"
	aStream 
		nextPutAll: '((';
		nextPutAll: aString;
		nextPut: $).
	self genCallOf: #firstIndexableField: with: aNode on: aStream.
	aStream nextPut: $)