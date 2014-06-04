ipv6 primitives
primitiveResolverGetAddressInfoResult: socketAddress

	| addrSize |
	self primitive: 'primitiveResolverGetAddressInfoResult'
		parameters: #(ByteArray).
	interpreterProxy failed
		ifFalse:
			[addrSize := interpreterProxy byteSizeOf: socketAddress cPtrAsOop.
			 self sqResolverGetAddressInfoResult: socketAddress Size: addrSize]