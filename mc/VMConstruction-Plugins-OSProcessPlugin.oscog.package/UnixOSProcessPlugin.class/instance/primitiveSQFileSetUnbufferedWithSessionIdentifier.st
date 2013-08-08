deprecated
primitiveSQFileSetUnbufferedWithSessionIdentifier
	"Take a struct SQFile from the stack, and call setbuf() to set the OS file stream (implemented in
	the C library) for unbuffered I/O. Answers the result of a fflush() call, not the result of the
	setbuf() call (which is type void). This is nearly useless, but may at least provide an indicator
	that we are operating on a valid file stream. Use this variant if the session identifier is not
	available directly in the VM (as may be the case if it is not possible to link from this plugin
	to a variable elsewhere in the VM)."

	| sqFileOop sqFile retVal thisSession |
	<export: true>
	<var: 'sqFile' declareC: 'SQFile *sqFile'>
	<var: 'thisSession' type: 'SESSIONIDENTIFIERTYPE'>
	sqFileOop := interpreterProxy stackValue: 1.
	(self isSQFileObject: sqFileOop) ifFalse: [^ interpreterProxy primitiveFail].
	sqFile := interpreterProxy arrayValueOf: sqFileOop.
	thisSession := self sessionIdentifierFrom: (interpreterProxy stackObjectValue: 0).
	(thisSession = (self cCode: 'sqFile->sessionID' inSmalltalk: [-1]))
		ifFalse: [^ interpreterProxy primitiveFail]
		ifTrue: [retVal := self cCode: 'fflush(sqFile->file)'.
				self cCode: 'setbuf(sqFile->file, NULL)'.
				interpreterProxy pop: 3; pushInteger: retVal]

