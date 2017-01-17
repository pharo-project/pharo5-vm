ipv6 primitives
primitiveResolverGetAddressInfoFamily

	| family |
	self primitive: 'primitiveResolverGetAddressInfoFamily'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[family := self sqResolverGetAddressInfoFamily.
			 ^family asSmallIntegerObj]