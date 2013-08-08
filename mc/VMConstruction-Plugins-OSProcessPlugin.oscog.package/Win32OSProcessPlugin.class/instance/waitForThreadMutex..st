private - thread synchronization
waitForThreadMutex: aHandle
	"To be called before entering a critical section."

	<returnTypeC: 'DWORD'>
	<var: 'aHandle' type: 'HANDLE'>
	^ self cCode: 'WaitForSingleObject(aHandle, INFINITE)'
