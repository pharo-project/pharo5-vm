primitives
primitiveSocketAbortConnection: socket

	| s |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketAbortConnection'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [
		self sqSocketAbortConnection: s]