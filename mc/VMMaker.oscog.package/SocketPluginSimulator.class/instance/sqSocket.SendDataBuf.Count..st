simulation
sqSocket: socketHandleCArray SendDataBuf: bufferStartCArray Count: numBytes
	| data |
	data := ByteArray new: numBytes.
	1 to: numBytes do:
		[:i| data at: i put: (bufferStartCArray at: i - 1)].
	^[Socket basicNew
			primSocket: ((self hostSocketHandleFromSimSocketHandle: socketHandleCArray) ifNil: [^0])
			sendData: data
			startIndex: 1
			count: numBytes]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			0]