translation
printTypedefOn: aStream
	super printTypedefOn: aStream.
	aStream
		cr;
		nextPutAll: '/* The callback return type codes */'; cr;
		nextPutAll: '#define retword 1'; cr;
		nextPutAll: '#define retword64 2'; cr;
		nextPutAll: '#define retdouble 3'; cr;
		nextPutAll: '#define retstruct 4'; cr;
		cr