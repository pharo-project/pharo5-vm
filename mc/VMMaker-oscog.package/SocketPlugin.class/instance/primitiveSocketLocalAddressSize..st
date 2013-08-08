ipv6 primitives
primitiveSocketLocalAddressSize: socket

	| s size |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketLocalAddressSize' parameters: #(#Oop).
	s := self socketValueOf: socket.
	interpreterProxy failed ifTrue: [^nil].
	size := self sqSocketLocalAddressSize: s.
	interpreterProxy failed ifTrue: [^nil].
	^size asSmallIntegerObj