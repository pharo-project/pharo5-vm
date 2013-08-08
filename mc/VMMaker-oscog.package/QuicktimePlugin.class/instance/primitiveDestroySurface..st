system primitives
primitiveDestroySurface: data 

	self primitive: 'primitiveDestroySurface' parameters: #(SmallInteger).
	self stQuicktimeDestroySurface: data.
	^nil