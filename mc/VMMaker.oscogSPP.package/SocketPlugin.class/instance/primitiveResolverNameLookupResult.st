primitives
primitiveResolverNameLookupResult

	| addr |
	self primitive: 'primitiveResolverNameLookupResult'.
	addr := self sqResolverNameLookupResult.
	^self intToNetAddress: addr