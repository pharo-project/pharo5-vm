primitives
primitiveSocket: socket connectTo: address port: port 
	| addr s okToConnect  |
	<var: #s type: 'SocketPtr'>
	self primitive: 'primitiveSocketConnectToPort' parameters: #(#Oop #ByteArray #SmallInteger ).
	addr := self netAddressToInt: (self cCoerce: address to: 'unsigned char *').
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCCTPfn ~= 0 ifTrue:
		[okToConnect := self cCode: ' ((sqInt (*) (sqInt, sqInt)) sCCTPfn)(addr, port)'.
		 okToConnect ifFalse:
			[^ interpreterProxy primitiveFail]].
	s := self socketValueOf: socket.
	interpreterProxy failed ifFalse:
		[self sqSocket: s ConnectTo: addr Port: port]