private - thread synchronization
createThreadMutex
	"Answer a HANDLE for a new mutex semaphore."

	<returnTypeC: 'HANDLE'>
	^ self cCode: 'CreateMutex(NULL, false, NULL)'
