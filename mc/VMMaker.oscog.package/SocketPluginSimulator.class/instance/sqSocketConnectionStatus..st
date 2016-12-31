simulation
sqSocketConnectionStatus: socketHandleCArray
	^[Socket basicNew
			primSocketConnectionStatus: ((self hostSocketHandleFromSimSocketHandle: socketHandleCArray) ifNil: [^-1])]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			-1]