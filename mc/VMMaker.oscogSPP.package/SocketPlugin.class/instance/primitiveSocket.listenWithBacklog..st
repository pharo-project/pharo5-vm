ipv6 primitives
primitiveSocket: socket listenWithBacklog: backlogSize

	| s  |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketListenWithBacklog' parameters: #(#Oop #SmallInteger).
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse: [self sqSocket: s ListenBacklog: backlogSize]