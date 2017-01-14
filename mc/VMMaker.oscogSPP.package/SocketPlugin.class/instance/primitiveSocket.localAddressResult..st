ipv6 primitives
primitiveSocket: socket localAddressResult: socketAddress

	| addrSize addrBase s  |
	<var: #addrBase type: 'char *'>
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketLocalAddressResult' parameters: #(#Oop #Oop).
	s := self socketValueOf: socket.
	addrSize := interpreterProxy byteSizeOf: socketAddress.
	addrBase := self cCoerce: (interpreterProxy firstIndexableField: socketAddress) to: 'char *'.
	interpreterProxy failed ifFalse: [self sqSocket: s LocalAddressResult: addrBase Size: addrSize]