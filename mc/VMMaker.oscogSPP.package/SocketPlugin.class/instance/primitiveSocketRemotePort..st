primitives
primitiveSocketRemotePort: socket

	| s port |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketRemotePort'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	port := self sqSocketRemotePort: s.
	^port asSmallIntegerObj