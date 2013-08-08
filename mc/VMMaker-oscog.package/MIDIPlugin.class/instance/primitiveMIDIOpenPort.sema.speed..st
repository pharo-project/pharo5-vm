primitives
primitiveMIDIOpenPort: portNum sema: semaIndex speed: clockRate

	self primitive: 'primitiveMIDIOpenPort'
		parameters: #(SmallInteger SmallInteger SmallInteger).
	self cCode: 'sqMIDIOpenPort(portNum, semaIndex, clockRate)'