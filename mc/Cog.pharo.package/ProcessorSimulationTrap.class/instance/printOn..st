printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: ' (pc: '; print: pc; nextPut: $/. pc printOn: aStream base: 16.
	aStream nextPutAll: ' nextpc: '; print: nextpc; nextPut: $/. nextpc printOn: aStream base: 16.
	aStream nextPutAll: ' address: '; print: address; nextPut: $/. address printOn: aStream base: 16.
	aStream nextPutAll: ' type: '; print: type.
	aStream nextPutAll: ' accessor: '; print: registerAccessor; nextPut: $)