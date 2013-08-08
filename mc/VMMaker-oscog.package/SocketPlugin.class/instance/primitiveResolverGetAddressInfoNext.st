ipv6 primitives
primitiveResolverGetAddressInfoNext

	| more |
	self primitive: 'primitiveResolverGetAddressInfoNext'
		parameters: #().
	more := self sqResolverGetAddressInfoNext.
	interpreterProxy failed ifTrue: [^nil].
	^more asBooleanObj