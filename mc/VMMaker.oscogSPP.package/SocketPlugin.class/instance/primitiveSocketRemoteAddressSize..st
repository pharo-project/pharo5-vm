ipv6 primitives
primitiveSocketRemoteAddressSize: socket

	| s size |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketRemoteAddressSize' parameters: #(#Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifTrue: [^nil].
	size := self sqSocketRemoteAddressSize: s.
	interpreterProxy failed ifTrue: [^nil].
	^size asSmallIntegerObj