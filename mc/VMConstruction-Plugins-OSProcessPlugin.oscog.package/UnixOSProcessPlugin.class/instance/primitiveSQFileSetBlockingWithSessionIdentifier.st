deprecated
primitiveSQFileSetBlockingWithSessionIdentifier
	"Take a struct SQFile from the stack, and call fcntl() to set the file for blocking I/O.
	Use this variant if the session identifier is not available directly in the VM (as may be
	the case if it is not possible to link from this plugin to a variable elsewhere in the VM)."

	| sqFile sqFileOop descriptor flags retVal thisSession |
	<export: true>
	<var: 'sqFile' declareC: 'SQFile *sqFile'>
	<var: 'thisSession' type: 'SESSIONIDENTIFIERTYPE'>
	sqFileOop := interpreterProxy stackValue: 1.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	sqFile := interpreterProxy arrayValueOf: sqFileOop.
	thisSession := self sessionIdentifierFrom: (interpreterProxy stackObjectValue: 0).
	(thisSession = (self cCode: 'sqFile->sessionID' inSmalltalk: [-1]))
		ifFalse:
			[^ interpreterProxy primitiveFail]
		ifTrue:
			[descriptor := self fileDescriptorFrom: sqFileOop.
			(descriptor < 0) ifTrue: [^ interpreterProxy primitiveFail].
			flags := self cCode: 'fcntl(descriptor, F_GETFL)'.
			retVal := self cCode: 'fcntl(descriptor, F_SETFL, flags & ~O_NONBLOCK)'.
			interpreterProxy pop: 3; pushInteger: retVal]

