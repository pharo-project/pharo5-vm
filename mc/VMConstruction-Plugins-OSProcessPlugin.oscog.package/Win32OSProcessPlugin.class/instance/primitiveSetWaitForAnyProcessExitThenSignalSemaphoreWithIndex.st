primitives - child process management
primitiveSetWaitForAnyProcessExitThenSignalSemaphoreWithIndex
	"Set up a thread to wait for a process HANDLE to exit, then signal the Semaphore
	at index. This provides asychronous notification of an external process exit. Answer
	the handle of the handler thread."

	| handleArrayOop handleArrayOopPtr handleArray handleArrayPtr handleCount arraySize idx semaIndex threadInformation |
	<export: true>
	<var: 'handleArrayOopPtr' type: 'unsigned int *'>
	<var: 'handleArray' declareC: 'static HANDLE handleArray[MAXIMUM_WAIT_OBJECTS]'>
	<var: 'handleArrayPtr' type: 'static HANDLE *'>
	<var: 'exitStatus' type: 'DWORD'>
	semaIndex := interpreterProxy stackIntegerValue: 0.
	handleArrayOop := interpreterProxy stackObjectValue: 1.
	handleArrayOopPtr := interpreterProxy firstIndexableField: handleArrayOop.
	handleCount := interpreterProxy stSizeOf: handleArrayOop.
	arraySize := self cCode: 'MAXIMUM_WAIT_OBJECTS' inSmalltalk: [64].
	(handleCount > arraySize) ifTrue: [^ interpreterProxy primitiveFail].
	idx := 0.
	[idx < handleCount] whileTrue:
		[handleArray at: idx put: (self handleFrom: (handleArrayOopPtr at: idx)).
		idx := idx + 1].
	handleArrayPtr := handleArray.
	threadInformation := self startHandlerThreadForAny: handleArrayPtr
							count: handleCount
							signalingSemaphoreAt: semaIndex.
	interpreterProxy pop: 3 thenPush: threadInformation
