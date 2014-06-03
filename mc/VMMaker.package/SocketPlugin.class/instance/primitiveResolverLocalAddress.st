primitives
primitiveResolverLocalAddress

	| addr |
	self primitive: 'primitiveResolverLocalAddress'.
	addr := self sqResolverLocalAddress.
	^self intToNetAddress: addr