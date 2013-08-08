primitives - signal forwarding
primitiveForwardSignalToSemaphore
	"Set a signal handler in the VM which will signal a Smalltalk semaphore at
	semaphoreIndex whenever an external signal sigNum is received. Answer the
	prior value of the signal handler. If semaphoreIndex is zero or nil, the handler
	is unregistered, and the VM returns to its default behavior for handling that
	signal.

	The Smalltalk semaphore is expected to be kept at the same index location
	indefinitely during the lifetime of a Squeak session. If that is not the case, the
	handler must be unregistered prior to unregistering the Smalltalk semaphore."

	| sigNum index semaphoreIndex handler priorHandler priorHandlerObject hPtr idx |
	<export: true>
	<var: 'handler' declareC: 'void *handler'>
	<var: 'priorHandler' declareC: 'union {void *handler; unsigned char bytes[sizeof(void *)];} priorHandler'>
	<var: 'hPtr' declareC: 'char *hPtr'>
	index := interpreterProxy stackValue: 0.
	(index == interpreterProxy nilObject)
		ifTrue:
			[semaphoreIndex := 0]
		ifFalse:
			[(interpreterProxy isIntegerObject: index)
				ifTrue:
					[semaphoreIndex := interpreterProxy stackIntegerValue: 0]
				ifFalse:
					[^ interpreterProxy primitiveFail]].
	sigNum := interpreterProxy stackIntegerValue: 1.
	handler := self forwardSignal: sigNum toSemaphoreAt: semaphoreIndex.
	(handler == self sigErrorNumber) ifTrue: [^ interpreterProxy primitiveFail].
	priorHandlerObject := interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: self sizeOfPointer.
	hPtr := interpreterProxy arrayValueOf: priorHandlerObject.
	self cCode: 'priorHandler.handler = handler'.
	idx := 0.
	[idx < self sizeOfPointer] whileTrue:
		[self cCode: 'hPtr[idx] = priorHandler.bytes[idx]'.
		idx := idx + 1].
	interpreterProxy pop: 3 thenPush: priorHandlerObject

