primitives
primitiveSerialPortWriteByName: portName from: array startingAt: startIndex count: count 
	<option: #PharoVM>
	<var: #port type: 'char *'>

	| bytesWritten arrayPtr portNameSize port |
	
	self primitive: 'primitiveSerialPortWriteByName'
		parameters: #(String ByteArray SmallInteger SmallInteger ).

	portNameSize := interpreterProxy slotSizeOf: (portName asOop: String).
	port := self cCode: 'calloc(portNameSize+1, sizeof(char))'.
	self cCode: 'memcpy(port, portName, portNameSize)'.

	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= (interpreterProxy byteSizeOf: array cPtrAsOop)]).
	interpreterProxy failed
		ifFalse: [arrayPtr := array + startIndex - 1.
			bytesWritten := self cCode: 'serialPortWriteFromByName(port, count, arrayPtr)' ].
	
	self free: port.

	^ bytesWritten asSmallIntegerObj