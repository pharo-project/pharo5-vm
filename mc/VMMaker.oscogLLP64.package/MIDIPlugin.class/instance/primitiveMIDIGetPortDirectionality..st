primitives
primitiveMIDIGetPortDirectionality: portNum

	|  dir |
	self primitive: 'primitiveMIDIGetPortDirectionality'
		parameters: #(SmallInteger).
	dir := self sqMIDIGetPortDirectionality: portNum.
	^dir asSmallIntegerObj