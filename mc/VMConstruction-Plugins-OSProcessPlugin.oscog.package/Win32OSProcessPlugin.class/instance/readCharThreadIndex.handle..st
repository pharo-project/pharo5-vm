private - nonblocking read thread
readCharThreadIndex: index handle: handle
	"This is the thread procedure for reading one character from a file or pipe
	handle. The values of index and handle have been passed on the local
	thread stack, so they are now local to the thread which is executing this
	method. Once the values are safely on a local thread stack, the mutex
	semaphore is released, allowing other threads to be created."

	| status |
	<returnTypeC: 'DWORD WINAPI'>
	<var: 'handle' type: 'HANDLE'>
	"Release mutex, allowing additional threads to be set up"
	self releaseThreadMutex: self readThreadMutexHandle.
	"Read a character, possibly waiting indefinitely"
	status := self cCode: 'ReadFile(handle, &readCharBufferArray[index], 1, &readCharCountArray[index], NULL)'.
	readCharStatusArray at: index put: status.
	"Ensure that this thread is still valid for this semaphore index."
	self GetCurrentThreadId = (readCharThreadIdArray at: index)
		ifTrue:
			["Signal Squeak that the character is now available"
			interpreterProxy signalSemaphoreWithIndex: index]
		ifFalse:
			["Invalidate any data we just placed in the buffer"
			readCharBufferArray at: index put: 0.
			readCharCountArray at: index put: 0.
			readCharStatusArray at: index put: 0].
	^ status
