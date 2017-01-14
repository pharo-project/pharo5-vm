simulation
sqSocketDestroy: socketHandleCArray 
	| simHandle hostHandle |
	simHandle := self simSocketHandleFrom: socketHandleCArray.
	hostHandle := simSocketToHostSocketMap removeKey: simHandle ifAbsent: [].
	hostHandle ifNil:
		[interpreterProxy primitiveFail.
		 ^self].
	hostSocketToSimSocketMap removeKey: hostHandle ifAbsent: [].
	[Socket basicNew primSocketDestroy: hostHandle]
		on: SocketPrimitiveFailed
		do: [:ex|
			interpreterProxy primitiveFail]