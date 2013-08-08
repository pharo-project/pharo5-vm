primitives - file descriptor
primitiveDup: fileDescriptor
	"Call dup() to duplicate a file descriptor using the next available descriptor. Answer
	the new file descriptor or -1 on failure."

	| result fd |
	<export: true>
	<var: 'oldfd' type: 'int'>
	<var: 'result' type: 'int'>
	fd := interpreterProxy stackIntegerValue: 0.
	result := self cCode: 'dup(fd)' inSmalltalk: [-1].
	interpreterProxy pop: 2; pushInteger: result

