primitives
primitiveSocketConnectionStatus: socket

	| s status |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketConnectionStatus'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [
		status := self sqSocketConnectionStatus: s].
	^ status asSmallIntegerObj