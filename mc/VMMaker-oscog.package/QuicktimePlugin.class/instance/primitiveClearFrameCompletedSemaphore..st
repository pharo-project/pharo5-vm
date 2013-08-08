system primitives
primitiveClearFrameCompletedSemaphore: data

	self primitive: 'primitiveClearFrameCompletedSemaphore' parameters: #(SmallInteger).
	self stQuicktimeClearSemaphore: data.
	^nil