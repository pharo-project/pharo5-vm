primitives
primitiveSerialPortOpenByName: portName baudRate: baudRate stopBitsType: stopBitsType parityType: parityType dataBits: dataBits inFlowControlType: inFlowControl outFlowControlType: outFlowControl xOnByte: xOnChar xOffByte: xOffChar
	<option: #PharoVM>
	<var: #port type: 'char *'>

	| port portNameSize |
	
	self primitive: 'primitiveSerialPortOpenByName'
		parameters: #(String SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger ).

	portNameSize := interpreterProxy slotSizeOf: (portName asOop: String).
	port := self cCode: 'calloc(portNameSize+1, sizeof(char))'.
	self cCode: 'memcpy(port, portName, portNameSize)'.
	
	self cCode: 'serialPortOpenByName(
			port, baudRate, stopBitsType, parityType, dataBits,
			inFlowControl, outFlowControl, xOnChar, xOffChar)'.
	
	self free: port.