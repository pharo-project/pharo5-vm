deprecated
primitiveSQFileFlushWithSessionIdentifier
	"Take a struct SQFile from the stack, and call fflush() to flush the OS stream. This flushes the
	file stream in the C library, not the stream in Smalltalk. For output streams, consider setting
	the OS stream (C library) to unbuffered output, and letting Smalltalk do all the buffering.
	The session identifier is passed as the parameter to this primitive. Use this variant if the session
	identifier is not available directly in the VM (as may be the case if it is not possible to link from
	this plugin to a variable elsewhere in the VM)."

	| sqFileOop result |
	<export: true>
	<var: 'result' type: 'int'>
	sqFileOop := interpreterProxy stackValue: 1.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	result := self fflush: (self fileHandleFrom: sqFileOop).
	interpreterProxy pop: 3; pushInteger: result