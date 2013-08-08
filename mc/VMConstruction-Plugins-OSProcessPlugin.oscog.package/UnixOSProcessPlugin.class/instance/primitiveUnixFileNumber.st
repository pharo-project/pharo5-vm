primitives - file descriptor
primitiveUnixFileNumber
	"Take a struct SQFile from the stack, and answer the value of its Unix file number.
	The Unix file number is not directly useful to Squeak, but may be interesting for
	debugging problems involving failure to close unused file handles."

	| sqFileOop fileNo |
	<export: true>
	<var: 'fileNo' type: 'int'>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	fileNo := self unixFileNumber: (self fileHandleFrom: sqFileOop).
	interpreterProxy pop: 2; pushInteger: fileNo
