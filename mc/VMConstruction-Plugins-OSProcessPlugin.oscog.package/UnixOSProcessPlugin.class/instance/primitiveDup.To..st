primitives - file descriptor
primitiveDup: oldFileDescriptor To: newFileDescriptor
	"Call dup2() to duplicate a file descriptor. Answer the duplicated file descriptor
	or -1 on failure."

	| result newfd oldfd |
	<export: true>
	<var: 'oldfd' type: 'int'>
	<var: 'newfd' type: 'int'>
	<var: 'result' type: 'int'>
	newfd := interpreterProxy stackIntegerValue: 0.
	oldfd := interpreterProxy stackIntegerValue: 1.
	result := self cCode: 'dup2(oldfd, newfd)' inSmalltalk: [-1].
	interpreterProxy pop: 3; pushInteger: result

