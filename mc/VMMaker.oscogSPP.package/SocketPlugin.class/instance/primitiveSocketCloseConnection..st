primitives
primitiveSocketCloseConnection: socket

	| s |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketCloseConnection'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [
		self sqSocketCloseConnection: s]