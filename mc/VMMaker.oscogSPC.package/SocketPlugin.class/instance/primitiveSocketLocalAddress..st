primitives
primitiveSocketLocalAddress: socket

	| s addr |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketLocalAddress'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	addr := self sqSocketLocalAddress: s.
	^self intToNetAddress: addr