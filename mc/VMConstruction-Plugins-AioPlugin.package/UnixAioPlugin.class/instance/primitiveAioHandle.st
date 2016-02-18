primitives
primitiveAioHandle
	"Handle asynchronous event notification for a descriptor. The first parameter is
	an OS level integer file descriptor. The remaining three parameters are Boolean
	flags representing the types of events for which notification is being requested:
	handle exceptions, handle for read, and handle for write.
	Flags are defined in the aio.h source as:
		AIO_X	(1<<0)	handle for exceptions
		AIO_R	(1<<1)	handle for read
		AIO_W	(1<<2)	handle for write"

	| fd exceptionWatch readWatch writeWatch flags |
	<export: true>
	(interpreterProxy nilObject = (interpreterProxy stackValue: 3))
		ifTrue: [^ interpreterProxy primitiveFail].
	fd := interpreterProxy stackIntegerValue: 3.
	(fd < 0) ifTrue: [^ interpreterProxy primitiveFail].
	exceptionWatch := interpreterProxy stackObjectValue: 2.
	readWatch := interpreterProxy stackObjectValue: 1.
	writeWatch := interpreterProxy stackObjectValue: 0.
	flags := 0.
	(exceptionWatch = interpreterProxy trueObject)
		ifTrue: [flags := flags bitOr: (self cCode: 'AIO_X' inSmalltalk: [1])].
	(readWatch = interpreterProxy trueObject)
		ifTrue: [flags := flags bitOr: (self cCode: 'AIO_R' inSmalltalk: [2])].
	(writeWatch = interpreterProxy trueObject)
		ifTrue: [flags := flags bitOr: (self cCode: 'AIO_W' inSmalltalk: [4])].
	self aio: fd Han: #aioForward:withData:andFlags: dle: flags.
	interpreterProxy pop: 5; pushInteger: flags
