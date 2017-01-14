ipv6 primitives
primitiveResolverHostNameSize

	| size |
	self primitive: 'primitiveResolverHostNameSize'
		parameters: #().
	interpreterProxy failed
		ifFalse:
			[size := self sqResolverHostNameSize.
			 interpreterProxy failed ifFalse: [^size asSmallIntegerObj]]