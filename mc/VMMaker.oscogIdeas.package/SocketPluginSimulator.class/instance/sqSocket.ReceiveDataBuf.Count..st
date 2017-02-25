simulation
sqSocket: socketHandleCArray ReceiveDataBuf: bufferStartCArray Count: numBytes
	^[| buffer n |
	  buffer := ByteArray new: numBytes.
	  n := Socket basicNew
			primSocket: ((self hostSocketHandleFromSimSocketHandle: socketHandleCArray) ifNil: [^0])
			receiveDataInto: buffer
			startingAt: 1
			count: numBytes.
	  1 to: n do:
		[:i|
		bufferStartCArray at: i - 1 put: (buffer at: i)].
	  n]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			0]