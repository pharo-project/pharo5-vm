private - exit handler thread
startHandlerThreadForAny: handleArrayPointer count: arraySize signalingSemaphoreAt: semaphoreIndex
	"Wait for a process HANDLE to exit, then signal the Semaphore at index. Answer
	the thread ID of the handler. This is the code to be executed in a thread to provide
	asychronous notification of an external process exit."

	| threadID hThread threadInformation threadArgs |
	<var: 'handleArrayPointer' type: 'HANDLE *'>
	<var: 'threadID' type: 'DWORD'>
	<var: 'hThread' type: 'HANDLE'>
	<var: 'threadArgs' type: 'static struct {int count; HANDLE *handles; int semaIndex;}'>

	"Complete setup of one handler before doing the next. Mutex will be
	released in the newly started thread."
	self waitForThreadMutex: self exitThreadMutexHandle.

	"Set up the thread argument structure."
	self cCode: 'threadArgs.count= arraySize'.
	self cCode: 'threadArgs.handles= handleArrayPointer'.
	self cCode: 'threadArgs.semaIndex= semaphoreIndex'.

	"N.B. Use STACK_SIZE_PARAM_IS_A_RESERVATION because Windows apparently ignores the stack size parameter
	 and uses the default in the executable.  So the only way to reduce memory usage is via STACK_SIZE_PARAM_IS_A_RESERVATION."
	self cPreprocessorDirective: '#if !defined(STACK_SIZE_PARAM_IS_A_RESERVATION)'.
	self cPreprocessorDirective: '#define STACK_SIZE_PARAM_IS_A_RESERVATION 0x10000'.
	self cPreprocessorDirective: '#endif'.
	hThread := self cCode: 'CreateThread(NULL, 1024, handleAnyChildProc, &threadArgs, STACK_SIZE_PARAM_IS_A_RESERVATION, &threadID)'.
	hThread isNil ifTrue: [^ interpreterProxy nilObject].
	interpreterProxy pushRemappableOop: (interpreterProxy positive32BitIntegerFor: threadID).
	interpreterProxy pushRemappableOop: (self handleObjectFrom: hThread).
	threadInformation := interpreterProxy
		instantiateClass: interpreterProxy classArray
		indexableSize: 2.
	interpreterProxy
		storePointer: 0
		ofObject: threadInformation
		withValue: interpreterProxy popRemappableOop.
	interpreterProxy
		storePointer: 1
		ofObject: threadInformation
		withValue: interpreterProxy popRemappableOop.
	^ threadInformation
