private - thread synchronization
readThreadMutexHandle
	"Answer a HANDLE for a mutex semaphore for sychronizing setup of read threads."

	| h |
	<returnTypeC: 'HANDLE'>
	<var: 'h' declareC: 'static HANDLE h= 0'>
	h isNil ifTrue: [h := self createThreadMutex].
	^ h
