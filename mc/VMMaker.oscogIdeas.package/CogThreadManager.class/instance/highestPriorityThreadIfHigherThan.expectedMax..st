public api
highestPriorityThreadIfHigherThan: activePriority expectedMax: maxPriority
	"Answer the first vmThread waiting to acquire the VM that is of higher priority
	 than activePriority, or answer nil if none. If there is a higher priority thread
	 then set the coInterpreter's maxWaitingPriority to either the priority of the
	 next highest priority vmThread, or to 0 if none is waiting."
	<returnTypeC: #'CogVMThread *'>
	| vmThread highest nextHighest |
	<var: #vmThread type: #'CogVMThread *'>
	<var: #highest type: #'CogVMThread *'>
	<var: #nextHighest type: #'CogVMThread *'>
	highest := nextHighest := nil.
	"To make this fair we could remember the last index at which we
	 found the highest and start the search at the following index."
	1 to: numThreads do:
		[:i|
		vmThread := threads at: i.
		vmThread state = CTMWantingOwnership ifTrue:
			[self assert: vmThread priority <= maxPriority.
			 highest isNil
				ifTrue: [highest := vmThread]
				ifFalse:
					[vmThread priority > highest priority
						ifTrue:
							[nextHighest := highest.
							highest := vmThread]
						ifFalse:
							[nextHighest isNil
								ifTrue: [nextHighest := vmThread]
								ifFalse: [vmThread priority > nextHighest priority ifTrue:
											[nextHighest := vmThread]]]]]].
	highest isNil ifTrue: [^nil].

	highest priority <= activePriority ifTrue:
		[^nil].
	coInterpreter setMaxWaitingPriorityTo: (nextHighest isNil
											ifTrue: [0]
											ifFalse: [nextHighest priority]).
	^highest