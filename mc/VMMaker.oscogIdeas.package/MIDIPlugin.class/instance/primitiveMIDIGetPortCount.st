primitives
primitiveMIDIGetPortCount

	| n |
	self primitive: 'primitiveMIDIGetPortCount'.
	n := self sqMIDIGetPortCount.
	^n asSmallIntegerObj
