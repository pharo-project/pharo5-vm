primitives
primitiveSerialPortReadByName: portName into: array startingAt: startIndex count: count 
	<option: #PharoVM>
	<var: #port type: 'char *'>

	| port portNameSize bytesRead arrayPtr |

	self primitive: 'primitiveSerialPortReadByName'
		parameters: #(String  ByteArray SmallInteger SmallInteger ).

	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= (interpreterProxy byteSizeOf: array cPtrAsOop)]).
	"adjust for zero-origin indexing"

	portNameSize := interpreterProxy slotSizeOf: (portName asOop: String).
	port := self cCode: 'calloc(portNameSize+1, sizeof(char))'.
	self cCode: 'memcpy(port, portName, portNameSize)'.

	arrayPtr := array + startIndex - 1.
	bytesRead := self cCode: 'serialPortReadIntoByName( port, count, arrayPtr)'.
	
	self free: port.
	
	^ bytesRead asSmallIntegerObj