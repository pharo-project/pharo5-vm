primitives
primitiveSocketSendDone: socket

	| s done |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketSendDone'
		parameters: #(Oop).
	s := self socketValueOf: socket.
	done := self sqSocketSendDone: s.
	^done asBooleanObj