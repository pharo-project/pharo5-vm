translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	"Generate the contents of interp.h on aStream.  Specific Interpreter subclasses
	 override to add more stuff."
	aStream
		nextPutAll: '#define VM_PROXY_MAJOR '; print: self vmProxyMajorVersion; cr;
		nextPutAll: '#define VM_PROXY_MINOR '; print: self vmProxyMinorVersion; cr;
		cr;
		nextPutAll: '#define SQ_VI_BYTES_PER_WORD '; print: bytesPerWord; cr;
		cr.
	((VMBasicConstants classPool associations select: [:a| a key beginsWith: 'PrimErr'])
		asSortedCollection: [:a1 :a2| a1 value <= a2 value])
		do: [:a|
			aStream nextPutAll: '#define '; nextPutAll: a key; space; print: a value; cr].
	aStream cr