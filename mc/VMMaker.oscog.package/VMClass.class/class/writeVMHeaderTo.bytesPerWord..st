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

	"The most basic constants must be defined here, not in e.g. the plugin sources, so allow those
	 other sources to be shared between different builds (Spur vs SqueakV3, 32-bit vs 64-bit, etc)"
	VMBasicConstants mostBasicConstantNames asSet asArray sort do:
		[:constName|
		(VMBasicConstants classPool at: constName ifAbsent: []) ifNotNil:
			[:const|
			aStream nextPutAll: '#define '; nextPutAll: constName; space; print: const; cr]].
	aStream cr.

	((VMBasicConstants classPool associations select: [:a| a key beginsWith: 'PrimErr'])
		asSortedCollection: [:a1 :a2| a1 value <= a2 value])
		do: [:a|
			aStream nextPutAll: '#define '; nextPutAll: a key; space; print: a value; cr].
	aStream cr.

	aStream
		nextPutAll: '#define MinSmallInteger '; print: self objectMemoryClass minSmallInteger; cr;
		nextPutAll: '#define MaxSmallInteger '; print: self objectMemoryClass maxSmallInteger; cr;
		cr.