ipv6 primitives
primitiveResolverGetNameInfoHostResult: socketName

	| addrSize |
	self primitive: 'primitiveResolverGetNameInfoHostResult'
		parameters: #(String).
	interpreterProxy failed
		ifFalse:
			[addrSize := interpreterProxy byteSizeOf: socketName cPtrAsOop.
			 self sqResolverGetNameInfoHostResult: socketName Size: addrSize]