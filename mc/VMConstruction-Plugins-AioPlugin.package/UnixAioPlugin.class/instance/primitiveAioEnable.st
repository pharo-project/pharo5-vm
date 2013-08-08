primitives
primitiveAioEnable
	"Enable asynchronous notification for a descriptor. The first parameter is an OS
	level integer file descriptor. The second parameter is the index of a Semaphore to
	be notified, and the third parameter is a flag indicating that descriptor represents
	an external object and should not be closed on termination of aio handling. Answer
	the semaphore index."

	| fd semaIndex flags externalObject eventSemaphoreIndices |
	<export: true>
	<var: 'eventSemaphoreIndices' declareC: 'static int eventSemaphoreIndices[FD_SETSIZE]'>
	(interpreterProxy nilObject = (interpreterProxy stackValue: 2))
		ifTrue: [^ interpreterProxy primitiveFail].
	fd := interpreterProxy stackIntegerValue: 2.
	(fd < 0) ifTrue: [^ interpreterProxy primitiveFail].
	semaIndex := interpreterProxy stackIntegerValue: 1.
	"The following is to prevent the need to coerce integers into pointers in clientData".
	eventSemaphoreIndices at: semaIndex put: semaIndex.
	externalObject := interpreterProxy stackObjectValue: 0.
	(externalObject = interpreterProxy trueObject)
		ifTrue: [flags := self cCode: 'AIO_EXT' inSmalltalk: [16]]
		ifFalse: [flags := 0].
	self cCode: 'aioEnable(fd, &(eventSemaphoreIndices[semaIndex]), flags)'.
	interpreterProxy pop: 4; pushInteger: semaIndex.