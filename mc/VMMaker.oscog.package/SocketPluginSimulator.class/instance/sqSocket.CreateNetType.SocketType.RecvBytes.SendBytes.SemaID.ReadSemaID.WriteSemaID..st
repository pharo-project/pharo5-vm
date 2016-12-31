simulation
sqSocket: sockPtr CreateNetType: netType SocketType: socketType RecvBytes: recvBufSize SendBytes: sendBufSize SemaID: semaIndex ReadSemaID: readSemaIndex WriteSemaID: writeSemaIndex
	"Simulate the sqSocketCreateNetTypeSocketTypeRecvBytesSendBytesSemaIDReadSemaIDWriteSemaID function.
	 We descend beneath the Socket abstraftion to simulate as accurately as possible."
	| semaphoresAndIndexes semaphores indexes socketHandle |
	semaphoresAndIndexes := Smalltalk newExternalSemaphores: 3.
	semaphores := semaphoresAndIndexes first.
	indexes := semaphoresAndIndexes second.
	socketHandle := [Socket basicNew
						primSocketCreateNetwork: netType
						type: socketType
						receiveBufferSize: recvBufSize
						sendBufSize: sendBufSize
						semaIndex: indexes first
						readSemaIndex: indexes second
						writeSemaIndex: indexes third]
			on: SocketPrimitiveFailed
			do: [:ex|
				#failed].
	socketHandle == #failed ifTrue:
		[interpreterProxy primitiveFail.
		 Smalltalk unregisterExternalObjects: semaphores.
		 ^self].
	"N.B. There is now a Processor yield in doSignalExternalSemaphores: every 100 virtual microseconds.
	 This allows these to make progress.  Their job is to map a host signal into a signal of the relevant index."
	self map:		socketHandle
		to:			sockPtr
		type:		socketType
		register:	semaphores
		spawning:	[[semaphores first wait. interpreterProxy  signalSemaphoreWithIndex: semaIndex] repeat]
		and:		[[semaphores second wait. interpreterProxy  signalSemaphoreWithIndex: readSemaIndex] repeat]
		and:		[[semaphores third wait. interpreterProxy  signalSemaphoreWithIndex: writeSemaIndex] repeat]