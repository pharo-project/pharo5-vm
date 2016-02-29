primitives
primitiveSocket: socket listenOnPort: port 
	"one part of the wierdass dual prim primitiveSocketListenOnPort which 
	was warped by some demented evil person determined to twist the very 
	nature of reality"
	| s  okToListen |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketListenOnPort' parameters: #(#Oop #SmallInteger ).
	s := self socketValueOf: socket.
	"If the security plugin can be loaded, use it to check for permission.
	If  not, assume it's ok"
	sCCLOPfn ~= 0 ifTrue:
		[okToListen := self cCode: ' ((sqInt (*) (sqInt, sqInt)) sCCLOPfn)((sqInt)s, port)'.
		 okToListen ifFalse:
			[^ interpreterProxy primitiveFail]].
	interpreterProxy failed ifFalse:
		[self sqSocket: s ListenOnPort: port]