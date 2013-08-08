private - thread synchronization
releaseThreadMutex: aHandle
	"To be called at the end of a critical section."

	<returnTypeC: 'BOOL'>
	<var: 'aHandle' type: 'HANDLE'>
	^ self ReleaseMutex: aHandle
