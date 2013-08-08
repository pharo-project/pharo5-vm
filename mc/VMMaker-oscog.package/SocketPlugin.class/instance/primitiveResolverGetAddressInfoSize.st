ipv6 primitives
primitiveResolverGetAddressInfoSize

	| size |
	self primitive: 'primitiveResolverGetAddressInfoSize'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[size := self sqResolverGetAddressInfoSize.
			 ^size asSmallIntegerObj]