ipv6 primitives
primitiveResolverGetNameInfoServiceSize

	| size |
	self primitive: 'primitiveResolverGetNameInfoServiceSize'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[size := self sqResolverGetNameInfoServiceSize.
			 ^size asSmallIntegerObj]