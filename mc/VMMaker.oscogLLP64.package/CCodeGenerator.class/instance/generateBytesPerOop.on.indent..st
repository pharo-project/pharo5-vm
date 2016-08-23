C translation
generateBytesPerOop: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 Would prefer to use OopSize than BytesPerOop (shorter)."

	aStream nextPutAll: 'BytesPerOop'