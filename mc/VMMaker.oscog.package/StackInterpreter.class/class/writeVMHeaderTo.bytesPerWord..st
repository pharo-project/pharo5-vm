translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	SistaVM ifTrue:
		[aStream nextPutAll: '#define SistaVM 1'; cr].
	NewspeakVM ifTrue:
		[aStream nextPutAll: '#define NewspeakVM 1'; cr].
	MULTIPLEBYTECODESETS ifTrue:
		[aStream nextPutAll: '#define MULTIPLEBYTECODESETS 1'; cr].
	IMMUTABILITY ifTrue:
		[aStream nextPutAll: '#define IMMUTABILITY 1'; cr].
	NewspeakVM | MULTIPLEBYTECODESETS | IMMUTABILITY ifTrue:
		[aStream cr].
	aStream nextPutAll: '#define STACKVM 1'; cr.
	(initializationOptions at: #SpurObjectMemory ifAbsent: false) ifTrue:
		[aStream nextPutAll: '#define SPURVM 1'; cr]