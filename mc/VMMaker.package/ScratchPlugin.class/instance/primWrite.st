serial port
primWrite
	"Write data to the given serial port from the given buffer (a ByteArray or String). Answer the number of bytes written."

	| portNum bufOop bytesWritten |
	<export: true>

	portNum := interpreterProxy stackIntegerValue: 1.
	bufOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: bufOop).
	interpreterProxy failed ifTrue: [^ 0].

	bytesWritten := self Serial: portNum
						Port: (self cCoerce: (interpreterProxy firstIndexableField: bufOop) to: 'char *')
						Write: (interpreterProxy stSizeOf: bufOop).

	interpreterProxy pop: 3.  						"pop args and rcvr"
	interpreterProxy pushInteger: bytesWritten.	"push result"
	^ 0