private - exit handler thread
threadMutexHandle
	"Answer a HANDLE for a mutex semaphore."

	| h |
	<returnTypeC: 'HANDLE'>
	<var: 'h' declareC: 'static HANDLE h= 0'>
	(h = 0) ifTrue: [h := self cCode: 'CreateMutex(NULL, false, NULL)'].
	^ h
