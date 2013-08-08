private - pipes
handleAnyChildProc: args
	"Wait for a process HANDLE to exit, then signal the Semaphore at index. Answer
	the exit status of the process. This is the code to be executed in a thread to provide
	asychronous notification of an external process exit."

	| threadArgs handles count index exitStatus |
	<returnTypeC: 'DWORD WINAPI'>
	<var: 'args' type: 'void *'>
	<var: 'threadArgs' type: 'struct {int count; HANDLE *handles; int semaIndex;} *'>
	<var: 'handles' type: 'volatile LPHANDLE'>
	<var: 'count' type: 'volatile int'>
	<var: 'index' type: 'volatile int'>
	<var: 'exitStatus' type: 'DWORD'>
	threadArgs := args.
	self cCode: 'count= threadArgs->count' inSmalltalk: [0].
	self cCode: 'handles= threadArgs->handles' inSmalltalk: [0].
	self cCode: 'index= threadArgs->semaIndex' inSmalltalk: [0].

	"Release mutex, allowing additional threads to be set up"
	self releaseThreadMutex: self exitThreadMutexHandle.

	exitStatus := self cCode: 'WaitForMultipleObjects(count, handles, FALSE, INFINITE)'.
	interpreterProxy signalSemaphoreWithIndex: index.
	^ exitStatus
