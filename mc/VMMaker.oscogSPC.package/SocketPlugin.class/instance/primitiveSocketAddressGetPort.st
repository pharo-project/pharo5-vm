ipv6 primitives
primitiveSocketAddressGetPort

	| addr addrSize addrBase port |
	<var: #addrBase type: 'char *'>
	addr := self primitive: 'primitiveSocketAddressGetPort' parameters: #() receiver: #Oop.
	addrSize := interpreterProxy byteSizeOf: addr.
	addrBase := self cCoerce: (interpreterProxy firstIndexableField: addr) to: 'char *'.
	interpreterProxy failed
		ifFalse:
			[port := self sqSocketAddress: addrBase SizeGetPort: addrSize.
			 interpreterProxy failed ifFalse: [^port asSmallIntegerObj]]