C translation
generateBytesPerWord: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 Would prefer to use WordSize than BytesPerWord (shorter) but e.g.
	 mpegtype.h has a parameter named WordSize."

	aStream nextPutAll: 'BytesPerWord'