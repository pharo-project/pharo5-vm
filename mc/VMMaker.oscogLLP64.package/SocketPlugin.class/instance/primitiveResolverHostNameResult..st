ipv6 primitives
primitiveResolverHostNameResult: nameString

	| nameSize |
	self primitive: 'primitiveResolverHostNameResult'
		parameters: #(String).
	interpreterProxy failed
		ifFalse:
			[nameSize := interpreterProxy byteSizeOf: nameString cPtrAsOop.
			 self sqResolverHostNameResult: nameString Size: nameSize]