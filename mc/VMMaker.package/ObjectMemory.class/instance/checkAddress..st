memory access
checkAddress: byteAddress 
	"Keep this method around for debugging the C code."
	(self oop: byteAddress isLessThan: self startOfMemory)
		ifTrue: [self error: 'bad address: negative'].
	(self oop: byteAddress isGreaterThanOrEqualTo: memoryLimit)
		ifTrue: [self error: 'bad address: past end of heap']