message forwarding
doesNotUnderstand: aMessage
	"Forward a message to the actual processor, managing a thread-switch if necessary.
	 Catch ProcessorSimulationTraps and raise them outside of the critical section to
	 avoid deadlock when reentering the VM from a trap and switching threads in the run-time."
	| selector result trap |
	selector := aMessage selector.
	(guardedProcessorProtocol includes: selector) ifFalse:
		[^(unguardedProcessorProtocol includes: selector)
			ifTrue: [processor perform: selector withArguments: aMessage arguments]
			ifFalse: [super doesNotUnderstand: aMessage]].
	result := [mutex critical:
				[owner ~~ mutex owningProcess ifTrue:
					[owner ifNotNil:
						[registerState at: owner put: processor registerState].
					 (registerState at: (owner := mutex owningProcess) ifAbsent: nil)
						ifNil: [coInterpreter initializeProcessorForThreadIndex: (threadIndex := threadIndex + 1)]
						ifNotNil: [:newState| processor setRegisterState: newState]].
				 processor perform: selector withArguments: aMessage arguments]]
					on: ProcessorSimulationTrap, Error
					do: [:ex| trap := ex].
	^trap ifNil: [result] ifNotNil: [trap signal]