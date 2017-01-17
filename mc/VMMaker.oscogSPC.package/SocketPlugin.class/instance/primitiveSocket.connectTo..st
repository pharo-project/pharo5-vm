ipv6 primitives
primitiveSocket: socket connectTo: socketAddress

	| addrSize addrBase s  |
	<var: #addrBase type: 'char *'>
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketConnectTo' parameters: #(#Oop #Oop).
	s := self socketValueOf: socket.
	addrSize := interpreterProxy byteSizeOf: socketAddress.
	addrBase := self cCoerce: (interpreterProxy firstIndexableField: socketAddress) to: 'char *'.
	interpreterProxy failed ifFalse: [self sqSocket: s ConnectToAddress: addrBase Size: addrSize]