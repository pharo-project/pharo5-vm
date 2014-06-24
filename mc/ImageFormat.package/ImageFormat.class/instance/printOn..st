printing
printOn: aStream

	aStream nextPutAll: 'ImageFormat fromInteger: ', self asInteger asString
