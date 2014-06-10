primitives
primitiveSocketLocalPort: socket

	| s port |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketLocalPort'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	port := self sqSocketLocalPort: s.
	^port asSmallIntegerObj