primitives
primitiveSocketError: socket

	| s err |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketError'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [
		err := self sqSocketError: s].
	^err asSmallIntegerObj