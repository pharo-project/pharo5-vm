system primitives
primitiveDestroyHandle: data 

	self primitive: 'primitiveDestroyHandle' parameters: #(SmallInteger).
	self stQuicktimeDestroy: data.
	^nil