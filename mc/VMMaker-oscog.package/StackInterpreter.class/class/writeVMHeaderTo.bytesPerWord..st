translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	NewspeakVM ifTrue:
		[aStream nextPutAll: '#define NewspeakVM 1'; cr].
	IMMUTABILITY ifTrue:
		[aStream nextPutAll: '#define IMMUTABILITY 1'; cr].
	NewspeakVM | IMMUTABILITY ifTrue:
		[aStream cr].
	aStream nextPutAll: '#define STACKVM 1'; cr; cr