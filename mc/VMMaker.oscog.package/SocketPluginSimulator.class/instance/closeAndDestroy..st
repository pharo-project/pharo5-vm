initialize-release
closeAndDestroy: socketHandle
	"c.f. Socket closeAndDestroy: timeoutSeconds"
	| fakeSocket |
	fakeSocket := Socket basicNew.
	[(fakeSocket primSocketConnectionStatus: socketHandle) = (Socket classPool at: #Connected) ifTrue:
		[fakeSocket primSocketCloseConnection: socketHandle].
	 fakeSocket
		primSocketAbortConnection: socketHandle;
		primSocketDestroy: socketHandle]
		on: SocketPrimitiveFailed
		do: [:ex| Transcript cr; show: ex message]