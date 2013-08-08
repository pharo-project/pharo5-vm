private - pthread
newPthreadTypeByteArray: aPthreadType
	"A pthread_t is an unsigned long, which may be 8 bytes on some 64 bit
	platforms. This stores the value in a byte array that can be easily
	passed to the image."

	| ptr len byteArray |
	<var: 'aPthreadType' type: 'pthread_t'>
	<var: 'ptr' declareC: 'pthread_t *ptr'>
	len := self cCode: 'sizeof(pthread_t)' inSmalltalk: [Smalltalk wordSize].
	byteArray := interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: len.
	ptr := interpreterProxy arrayValueOf: byteArray.
	ptr at: 0 put: aPthreadType.
	^ byteArray
