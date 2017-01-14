ipv6 primitives
primitiveResolverGetNameInfoServiceResult: socketName

	| addrSize |
	self primitive: 'primitiveResolverGetNameInfoServiceResult'
		parameters: #(String).
	interpreterProxy failed
		ifFalse:
			[addrSize := interpreterProxy byteSizeOf: socketName cPtrAsOop.
			 self sqResolverGetNameInfoServiceResult: socketName Size: addrSize]