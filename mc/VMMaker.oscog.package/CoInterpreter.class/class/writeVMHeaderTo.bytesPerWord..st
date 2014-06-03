translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	aStream
		nextPutAll: '#define COGVM 1'; cr;
		nextPutAll: '#if !defined(COGMTVM)'; cr;
		nextPutAll: '#	define COGMTVM 0'; cr;
		nextPutAll: '#endif'; cr