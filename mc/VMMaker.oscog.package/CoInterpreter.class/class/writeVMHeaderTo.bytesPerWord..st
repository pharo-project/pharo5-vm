translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord.
	aStream
		nextPutAll: '#define COGVM 1'; cr;
		nextPutAll: '#if !defined(COGMTVM)'; cr;
		nextPutAll: '#	define COGMTVM 0'; cr;
		nextPutAll: '#endif'; cr; cr.
	"This constant is a hack for the MT VM on SqueakV3.  Eventually it will disappear.
	 But having it here rather than in CoInterpreterMT means that the interp.h header
	 doesn't  get regenerated every time the sources are, which means less recompilation."
	((VMBasicConstants classPool associations select: [:a| a key beginsWith: 'DisownVM'])
		asSortedCollection: [:a1 :a2| a1 value <= a2 value])
		do: [:a|
			aStream nextPutAll: '#define '; nextPutAll: a key; space; print: a value; cr]