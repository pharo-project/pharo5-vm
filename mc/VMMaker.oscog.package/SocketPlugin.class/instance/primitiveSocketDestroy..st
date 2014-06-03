primitives
primitiveSocketDestroy: socket

	| s |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketDestroy'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [
		self sqSocketDestroy: s]