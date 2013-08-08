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
	semaIndices = nil ifTrue: [^nil]. "Interpreter simulation"
	(semaphoreIndex == 0)
		ifTrue:
			["Disable the handler"
			((semaIndices at: sigNum) ~= 0)
				ifTrue:
					[oldHandler := self originalSignalHandlers at: sigNum.
					oldHandler := self setSignalNumber: sigNum handler: oldHandler.
					semaIndices at: sigNum put: 0.
					^ oldHandler]
				ifFalse: "either -1 for printAllStacks or a positive integer for semaphore forwarding"
					["Signal handler had not been set, answer an error"
					^ self sigErrorNumber]].
	((semaIndices at: sigNum) > 0)
		ifTrue:
			["Handler is already set, answer an error"
			^ self sigErrorNumber].
	oldHandler := self setSignalNumber: sigNum handler: (self handleSignalFunctionAddress).
	(oldHandler ~= self sigErrorNumber)
		ifTrue:
			[self originalSignalHandlers at: sigNum put: oldHandler.
			semaIndices at: sigNum put: semaphoreIndex].
	^ oldHandler
