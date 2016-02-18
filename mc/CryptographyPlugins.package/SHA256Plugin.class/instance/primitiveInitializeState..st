primitives
primitiveInitializeState: state

	self primitive: 'primitiveInitializeState' parameters: #(ByteArray).
	self sha256InitializeState: (self cCoerce: state to: #'unsigned int*')
