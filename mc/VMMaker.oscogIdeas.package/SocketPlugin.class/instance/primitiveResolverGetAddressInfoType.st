ipv6 primitives
primitiveResolverGetAddressInfoType

	| type |
	self primitive: 'primitiveResolverGetAddressInfoType'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[type := self sqResolverGetAddressInfoType.
			 ^type asSmallIntegerObj]