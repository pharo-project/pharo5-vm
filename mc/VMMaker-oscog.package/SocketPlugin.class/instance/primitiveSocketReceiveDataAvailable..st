primitives
primitiveSocketReceiveDataAvailable: socket

	| s dataIsAvailable |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketReceiveDataAvailable'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	dataIsAvailable := self sqSocketReceiveDataAvailable: s.
	^dataIsAvailable asBooleanObj