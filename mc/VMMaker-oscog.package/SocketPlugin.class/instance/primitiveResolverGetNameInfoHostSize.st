ipv6 primitives
primitiveResolverGetNameInfoHostSize

	| size |
	self primitive: 'primitiveResolverGetNameInfoHostSize'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[size := self sqResolverGetNameInfoHostSize.
			 ^size asSmallIntegerObj]