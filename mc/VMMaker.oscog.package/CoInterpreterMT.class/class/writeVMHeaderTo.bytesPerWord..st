translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	aStream cr.
	((VMBasicConstants classPool associations select: [:a| a key beginsWith: 'DisownVM'])
		asSortedCollection: [:a1 :a2| a1 value <= a2 value])
		do: [:a|
			aStream nextPutAll: '#define '; nextPutAll: a key; space; print: a value; cr]