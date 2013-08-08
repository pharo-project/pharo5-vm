private - thread synchronization
exitThreadMutexHandle
	"Answer a HANDLE for a mutex semaphore for the child handler thread."

	| h |
	<returnTypeC: 'HANDLE'>
	<var: 'h' declareC: 'static HANDLE h= 0'>
	h isNil ifTrue: [h := self createThreadMutex].
	^ h
