primitives
primitiveAioDisable
	"Definitively disable asynchronous event notification for a descriptor. The
	parameter is an OS level integer file descriptor."

	| fd |
	<export: true>
	(interpreterProxy nilObject = (interpreterProxy stackValue: 0))
		ifTrue: [^ interpreterProxy primitiveFail].
	fd := interpreterProxy stackIntegerValue: 0.
	(fd < 0) ifTrue: [^ interpreterProxy primitiveFail].
	self aioDisable: fd.
	interpreterProxy pop: 2; pushInteger: fd
