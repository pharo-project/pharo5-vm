primitives - files
primitiveSQFileSetBlocking
	"Take a struct SQFile from the stack, and call fcntl() to set the file for blocking I/O."

	| sqFileOop descriptor flags retVal |
	<export: true>
	<var: 'flags' type: 'int'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	descriptor := self fileDescriptorFrom: sqFileOop.
	(descriptor = -1) ifTrue: [^ interpreterProxy primitiveFail].
	flags := self cCode: 'fcntl(descriptor, F_GETFL)'.
	retVal := self cCode: 'fcntl(descriptor, F_SETFL, flags & ~O_NONBLOCK)'.
	interpreterProxy pop: 2; pushInteger: retVal

