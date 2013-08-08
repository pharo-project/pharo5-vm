primitives - files
primitiveSQFileFlush
	"Take a struct SQFile from the stack, and call fflush() to flush the OS stream. This flushes the
	file stream in the C library, not the stream in Smalltalk. For output streams, consider setting
	the OS stream (C library) to unbuffered output, and letting Smalltalk do all the buffering."

	| sqFileOop result |
	<export: true>
	<var: 'result' type: 'int'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	result := self fflush: (self fileHandleFrom: sqFileOop).
	interpreterProxy pop: 2; pushInteger: result
