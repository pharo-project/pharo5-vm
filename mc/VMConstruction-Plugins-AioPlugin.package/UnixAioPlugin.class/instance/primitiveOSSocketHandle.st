primitives
primitiveOSSocketHandle
	"Take a struct SQSocket from the stack, and answer the value of its Unix file number."

	| sqSocketOop fileNo |
	<export: true>
	sqSocketOop := interpreterProxy stackValue: 0.
	(self isSQSocketObject: sqSocketOop) ifFalse: [^ interpreterProxy primitiveFail].
	fileNo := self socketDescriptorFrom: sqSocketOop.
	(fileNo < 0) ifTrue: [^ interpreterProxy primitiveFail].
	interpreterProxy pop: 2; pushInteger: fileNo
