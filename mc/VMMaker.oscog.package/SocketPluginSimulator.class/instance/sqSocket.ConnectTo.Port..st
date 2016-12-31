simulation
sqSocket: socketHandle ConnectTo: addr Port: port
	^[Socket basicNew
			primSocket: ((self hostSocketHandleFromSimSocketHandle: socketHandle) ifNil: [^self])
			connectTo: (self netAddressAsByteArrayFromInt: addr)
			port: port]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			0]