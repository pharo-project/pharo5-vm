primitives - files
primitiveSQFileSetUnbuffered
	"Take a struct SQFile from the stack, and call setbuf() to set the OS file stream
	(implemented in the C library) for unbuffered I/O. Answers the result of a fflush()
	call, not the result of the setbuf() call (which is type void). This is nearly useless,
	but may at least provide an indicator that we are operating on a valid file stream."

	| sqFileOop retVal file |
	<export: true>
	<var: 'file' type: 'FILEHANDLETYPE'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	file := self fileHandleFrom: sqFileOop.
	retVal := self fflush: file.
	self set: file buf: 0. "sebuf(file, NULL)"
	interpreterProxy pop: 2; pushInteger: retVal

