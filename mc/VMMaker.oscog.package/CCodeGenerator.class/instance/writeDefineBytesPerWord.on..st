public
writeDefineBytesPerWord: bytesPerWord on: aStream
	aStream
		nextPutAll: '#define SQ_VI_BYTES_PER_WORD ';
		print: bytesPerWord;
		cr
