private - event forwarding
aioForward: fd withData: data andFlags: flags
	"This function is called to signal a Smalltalk Semaphore when an asynchronous event is
	detected. When translated to C, the name of this method is aioForwardwithDataandFlags.
	The event handler is set up by #primitiveAioHandle."

	| semaIndex pfd |
	<returnTypeC: 'void'>
	<var: 'fd' type: 'int'>
	<var: 'data' type: 'void *'>
	<var: 'flags' type: 'int'>
	<var: 'pfd' declareC: 'int *pfd'>
	pfd := data.
	semaIndex := self cCode: '*pfd' inSmalltalk: [0].
	interpreterProxy signalSemaphoreWithIndex: semaIndex
