ipv6 primitives
primitiveResolverGetAddressInfoProtocol

	| protocol |
	self primitive: 'primitiveResolverGetAddressInfoProtocol'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[protocol := self sqResolverGetAddressInfoProtocol.
			 ^protocol asSmallIntegerObj]