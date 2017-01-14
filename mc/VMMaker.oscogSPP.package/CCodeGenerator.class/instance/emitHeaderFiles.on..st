C code generator
emitHeaderFiles: headerFilesSubSequence on: aStream
	headerFilesSubSequence do:
		[:hdr|
		hdr first ~= $# ifTrue:
			[aStream nextPutAll: '#include '].
		aStream nextPutAll: hdr; cr]