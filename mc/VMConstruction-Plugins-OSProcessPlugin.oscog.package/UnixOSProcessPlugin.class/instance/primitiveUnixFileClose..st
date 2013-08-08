primitives - file descriptor
primitiveUnixFileClose: anIntegerFileNumber
	"Close a file handle at the close(2) level, using a handle returned by
	#primitiveUnixFileNumber."

	|  handle result |
	<export: true>
	<var: 'handle' type: 'int'>
	<var: 'result' type: 'int'>
	handle := interpreterProxy stackIntegerValue: 0.
	result := self cCode: 'close(handle)' inSmalltalk: [-1].
	interpreterProxy pop: 2; pushInteger: result

