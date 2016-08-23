primitives
primitiveSocket: socket bindTo: address port: port 
	| addr s  |
	<var: #s declareC: 'SocketPtr s'>
	self primitive: 'primitiveSocketBindToPort' parameters: #(#Oop #ByteArray #SmallInteger ).
	addr := self
				netAddressToInt: (self cCoerce: address to: 'unsigned char *').
	s := self socketValueOf: socket.
	interpreterProxy failed 
		ifFalse:[self sqSocket: s BindTo: addr Port: port]