primitives
primitiveSerialPortClose: portNum

	self primitive: 'primitiveSerialPortClose'
		parameters: #(SmallInteger).
	self serialPortClose: portNum