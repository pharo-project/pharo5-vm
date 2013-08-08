primitives - nonblocking read
primitiveNextFromSignaling
	"Read the next character from anIOHandle (a SQFile struct) into a buffer in the VM. When
	the read completes, signal the specified Semaphore to notify that the character is available.
	Answer the handle of the new thread, or nil on error."

	| index handle hThread threadArgs threadID |
	<export: true>
	<var: 'index' type: 'static int'>
	<var: 'handle' type: 'HANDLE'>
	<var: 'hThread' type: 'HANDLE'>
	<var: 'threadID' declareC: 'DWORD threadID'>
	<var: 'threadArgs' declareC: 'static struct {int index; HANDLE handle;} threadArgs'>

	index := interpreterProxy stackIntegerValue: 0.
	(index >= readCharArraySize) ifTrue: [^ interpreterProxy primitiveFail].

	"Complete setup of one handler before doing the next. Mutex will be
	released in the newly started thread."
	self waitForThreadMutex: self readThreadMutexHandle.

	handle := self handleFromSQFile: (interpreterProxy stackObjectValue: 1).
	handle isNil ifTrue: [^ nil]. "Fail if not a handle, probably due to file having been closed"
	readCharBufferArray at: index put: 0.
	readCharCountArray at: index put: 0.
	readCharStatusArray at: index put: 0.
	self cCode: 'threadArgs.index = index'.
	self cCode: 'threadArgs.handle = handle'.
	"N.B. Use STACK_SIZE_PARAM_IS_A_RESERVATION because Windows apparently ignores the stack size parameter
	 and uses the default in the executable.  So the only way to reduce memory usage is via STACK_SIZE_PARAM_IS_A_RESERVATION."
	self cPreprocessorDirective: '#if !defined(STACK_SIZE_PARAM_IS_A_RESERVATION)'.
	self cPreprocessorDirective: '#define STACK_SIZE_PARAM_IS_A_RESERVATION 0x10000'.
	self cPreprocessorDirective: '#endif'.
	hThread := self cCode: 'CreateThread(NULL, 1024, readCharThread, &threadArgs, STACK_SIZE_PARAM_IS_A_RESERVATION, &threadID)'.
	"Safety net: Remember the identity of the thread which should be active for this
	semaphore index."
	readCharThreadIdArray at: index put: threadID.
	hThread isNil ifTrue: [^ interpreterProxy nilObject].
	interpreterProxy pop: 3 thenPush: (self handleObjectFrom: hThread)
