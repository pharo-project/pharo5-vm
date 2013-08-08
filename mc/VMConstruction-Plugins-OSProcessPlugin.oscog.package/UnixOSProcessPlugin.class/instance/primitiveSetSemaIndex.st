deprecated
primitiveSetSemaIndex
	"Set the index of the semaphore used by the OSProcess with which I collaborate. My
	OSProcess should set this value so that I can use it when handling SIGCHLD signals
	(death of child). In the C translation this is a static int which would be shared by all
	instances of UnixOSProcessPlugin, which is expected to be a singleton. Answer the
	value of the semaphore index."

	<export: true>
	sigChldSemaIndex := interpreterProxy stackIntegerValue: 0.
	interpreterProxy pop: 2; pushInteger: sigChldSemaIndex
