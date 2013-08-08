printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: ' (pc: '; print: pc.
	aStream nextPutAll: ' nextpc: '; print: nextpc.
	aStream nextPutAll: ' address: '; print: address.
	aStream nextPutAll: ' type: '; print: type.
	aStream nextPutAll: ' accessor: '; print: registerAccessor; nextPut: $)