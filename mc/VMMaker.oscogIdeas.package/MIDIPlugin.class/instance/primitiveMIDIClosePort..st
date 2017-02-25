primitives
primitiveMIDIClosePort: portNum

	self primitive: 'primitiveMIDIClosePort'
		parameters: #(SmallInteger).
	self sqMIDIClosePort: portNum