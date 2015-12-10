primitives
primitiveFinalHash: x fromState: s

	self primitive: 'primitiveFinalHashFromState' parameters: #(ByteArray ByteArray).
	self copy: s into: x count: 8
