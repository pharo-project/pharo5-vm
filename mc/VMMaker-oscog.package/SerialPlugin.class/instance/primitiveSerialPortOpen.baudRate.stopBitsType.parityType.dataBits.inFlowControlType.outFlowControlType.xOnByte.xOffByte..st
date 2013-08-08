primitives
primitiveSerialPortOpen: portNum baudRate: baudRate stopBitsType: stopBitsType parityType: parityType dataBits: dataBits inFlowControlType: inFlowControl outFlowControlType: outFlowControl xOnByte: xOnChar xOffByte: xOffChar

	self primitive: 'primitiveSerialPortOpen'
		parameters: #(SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger SmallInteger ).

	self cCode: 'serialPortOpen(
			portNum, baudRate, stopBitsType, parityType, dataBits,
			inFlowControl, outFlowControl, xOnChar, xOffChar)'