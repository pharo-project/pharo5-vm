primitives
primitiveProcessBuffer: buffer withState: state

	self primitive: 'primitiveProcessBufferWithState' parameters: #(ByteArray ByteArray).
	self 
		sha256ProcessBuffer: (self cCoerce: buffer to: #'unsigned int*')
		withState: (self cCoerce: state to: #'unsigned int*')
