private - signal handers
forwardSignal: sigNum toSemaphoreAt: semaphoreIndex
	"Set a signal handler in the VM which will signal a Smalltalk semaphore at
	semaphoreIndex whenever an external signal sigNum is received. Answer the
	prior value of the signal handler. If semaphoreIndex is zero, the handler is
	unregistered, and the VM returns to its default behavior for handling that
	signal. A handler must be unregistered before it can be registered again.

	The Smalltalk semaphore is expected to be kept at the same index location
	indefinitely during the lifetime of a Squeak session. If that is not the case, the
	handler must be unregistered prior to unregistering the Smalltalk semaphore."

	| oldHandler |
	<returnTypeC: 'void *'>
	<var: 'oldHandler' type: 'void *'>
	(semaphoreIndex == 0)
		ifTrue:
			["Disable the handler"
			((self semaphoreIndices at: sigNum) ~= 0)
				ifTrue:
					[oldHandler := self setSignalNumber: sigNum handler: oldHandler.
					self semaphoreIndices at: sigNum put: 0.
					^ oldHandler]
				ifFalse:
					["Signal handler had not been set, answer an error"
					^ self sigErrorNumber]].
	((self semaphoreIndices at: sigNum) > 0)
		ifTrue:
			["Handler is already set, answer an error"
			^ self sigErrorNumber].
	oldHandler := self setSignalNumber: sigNum handler: (self handleSignalFunctionAddress).
	(oldHandler ~= self sigErrorNumber)
		ifTrue:
			[self originalSignalHandlers at: sigNum put: oldHandler.
			self semaphoreIndices at: sigNum put: semaphoreIndex].
	^ oldHandler
