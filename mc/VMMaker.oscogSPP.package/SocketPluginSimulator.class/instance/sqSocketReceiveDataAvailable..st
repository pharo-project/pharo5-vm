simulation
sqSocketReceiveDataAvailable: socketHandleCArray 
	^[Socket basicNew
			primSocketReceiveDataAvailable: ((self hostSocketHandleFromSimSocketHandle: socketHandleCArray) ifNil: [^false])]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail.
			false]