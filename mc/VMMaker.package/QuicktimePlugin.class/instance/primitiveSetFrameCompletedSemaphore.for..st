system primitives
primitiveSetFrameCompletedSemaphore: semaIndex for: data

	self primitive: 'primitiveSetFrameCompletedSemaphore'  parameters:#(SmallInteger SmallInteger).
	self stQuicktimeSetSemaphore: semaIndex for: data.
	^nil