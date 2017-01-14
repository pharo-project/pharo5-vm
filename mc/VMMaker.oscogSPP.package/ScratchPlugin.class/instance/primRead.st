serial port
primRead
	"Read data from the given serial port into the given buffer (a ByteArray or String). Answer the number of bytes read."

	| portNum bufOop bytesRead |
	<export: true>

	portNum := interpreterProxy stackIntegerValue: 1.
	bufOop := interpreterProxy stackValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: bufOop).
	interpreterProxy failed ifTrue: [^ 0].

	bytesRead := self Serial: portNum
						Port: (self cCoerce: (interpreterProxy firstIndexableField: bufOop) to: 'char *')
						Read: (interpreterProxy stSizeOf: bufOop).

	interpreterProxy pop: 3.  					"pop args and rcvr"
	interpreterProxy pushInteger: bytesRead.	"push result"
	^ 0