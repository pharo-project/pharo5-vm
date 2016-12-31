simulation
sqSocketSendDone: socketHandleCArray
	^[Socket basicNew
			primSocketSendDone: ((self hostSocketHandleFromSimSocketHandle: socketHandleCArray) ifNil: [^false])]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			false]