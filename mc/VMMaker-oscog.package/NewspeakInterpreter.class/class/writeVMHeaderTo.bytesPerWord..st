translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	aStream
		nextPutAll: '#define NewspeakVM 1'; cr;
		nextPutAll: '#define ALIEN_FFI 1'; cr;
		nextPutAll: '#define IMMUTABILITY 1'; cr;
		nextPutAll: '#define BigEndianFloats 1'; cr;
		cr