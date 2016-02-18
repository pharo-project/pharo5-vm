primitives
primitiveInitializeState: state

	self primitive: 'primitiveInitializeState' parameters: #(ByteArray).
	self md5InitializeState: (self cCoerce: state to: #'unsigned int*')
