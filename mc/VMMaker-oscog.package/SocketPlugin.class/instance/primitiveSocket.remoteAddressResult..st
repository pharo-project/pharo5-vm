ipv6 primitives
primitiveSocket: socket remoteAddressResult: socketAddress

	| addrSize addrBase s  |
	<var: #addrBase type: 'char *'>
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketRemoteAddressResult' parameters: #(#Oop #Oop).
	s := self socketValueOf: socket.
	addrSize := interpreterProxy byteSizeOf: socketAddress.
	addrBase := self cCoerce: (interpreterProxy firstIndexableField: socketAddress) to: 'char *'.
	interpreterProxy failed ifFalse: [self sqSocket: s RemoteAddressResult: addrBase Size: addrSize]