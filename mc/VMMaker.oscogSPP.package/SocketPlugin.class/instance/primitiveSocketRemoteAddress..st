primitives
primitiveSocketRemoteAddress: socket

	| s addr |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketRemoteAddress'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	addr := self sqSocketRemoteAddress: s.
	^self intToNetAddress: addr