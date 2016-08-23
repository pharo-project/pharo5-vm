C translation
generateBitInvert: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 If the selector is bitInvert32 then cast to unsigned int to ensure
	 a 32-bit value on 64-bit platforms."

	| castToUnsignedInt |
	castToUnsignedInt := msgNode selector = #bitInvert32.
	castToUnsignedInt ifTrue:
		[aStream nextPutAll: '(unsigned int)'].
	aStream nextPut: $~.
	self emitCExpression: msgNode receiver on: aStream