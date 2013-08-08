ipv6 primitives
primitiveResolverGetNameInfo: socketAddress flags: flags

	| addrSize addrBase |
	<var: #addrBase type: 'char *'>
	self primitive: 'primitiveResolverGetNameInfo'
		parameters: #(Oop SmallInteger).
	interpreterProxy failed
		ifFalse:
			[addrSize := interpreterProxy byteSizeOf: socketAddress.
			 addrBase := self cCoerce: (interpreterProxy firstIndexableField: socketAddress) to: 'char *'.
			 self sqResolverGetNameInfo: addrBase Size: addrSize Flags: flags]