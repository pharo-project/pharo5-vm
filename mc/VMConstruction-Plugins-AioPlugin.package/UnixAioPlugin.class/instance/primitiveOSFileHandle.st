primitives
primitiveOSFileHandle
	"Take a struct SQFile from the stack, and answer the value of its Unix file number."

	| sqFileOop fileNo |
	<export: true>
	sqFileOop := interpreterProxy stackValue: 0.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	fileNo := self fileDescriptorFrom: sqFileOop.
	interpreterProxy pop: 2; pushInteger: fileNo
