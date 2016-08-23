ipv6 primitives
primitiveSocketAddressSetPort: portNumber

	| addr addrSize addrBase |
	<var: #addrBase type: 'char *'>
	addr := self primitive: 'primitiveSocketAddressSetPort' parameters: #(SmallInteger) receiver: #Oop.
	addrSize := interpreterProxy byteSizeOf: addr.
	addrBase := self cCoerce: (interpreterProxy firstIndexableField: addr) to: 'char *'.
	interpreterProxy failed ifFalse: [self sqSocketAddress: addrBase Size: addrSize SetPort: portNumber]