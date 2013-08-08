primitives
primitiveDecrypt
	"Primitive. Decrypts a buffer sent via the connection.
	Requires the session to be established.
	Returns:
		>=0 - Number of bytes decrypted in the result buffer
		< -1 - Other errors.
	"
	| start srcLen dstLen srcOop dstOop handle srcPtr dstPtr result |
	self var: #srcPtr type: 'char *'.
	self var: #dstPtr type: 'char *'.
	self export: true.
	interpreterProxy methodArgumentCount = 5
		ifFalse:[^interpreterProxy primitiveFail].
	dstOop := interpreterProxy stackObjectValue: 0.
	srcLen := interpreterProxy stackIntegerValue: 1.
	start := interpreterProxy stackIntegerValue: 2.
	srcOop := interpreterProxy stackObjectValue: 3.
	handle := interpreterProxy stackIntegerValue: 4.
	interpreterProxy failed ifTrue:[^nil].
	((start > 0 and:[srcLen >= 0])
		and:[(interpreterProxy isBytes: srcOop) 
		and:[(interpreterProxy isBytes: dstOop) 
		and:[(interpreterProxy byteSizeOf: srcOop) >= (start + srcLen - 1)]]])
			ifFalse:[^interpreterProxy primitiveFail].
	srcPtr := interpreterProxy firstIndexableField: srcOop.
	dstPtr := interpreterProxy firstIndexableField: dstOop.
	srcPtr := srcPtr + start - 1.
	dstLen := interpreterProxy byteSizeOf: dstOop.
	result := self cCode: 'sqDecryptSSL(handle, srcPtr, srcLen, dstPtr, dstLen)' 
					inSmalltalk:[handle. srcPtr. srcLen. dstPtr. dstLen. -2].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount+1.
	interpreterProxy pushInteger: result.