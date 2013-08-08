simulation only
simulateLeafCallOf: someFunction
	"Simulate execution of machine code that leaf-calls someFunction,
	 answering the result returned by someFunction."
	<doNotGenerate>
	| spOnEntry |
	self recordRegisters.
	processor
		simulateLeafCallOf: someFunction
		nextpc: 16rBADF00D5
		memory: coInterpreter memory.
	spOnEntry := processor sp.
	self recordInstruction: {'(simulated call of '. someFunction. ')'}.
	[[processor pc between: 0 and: coInterpreter cogCodeSize] whileTrue:
		[singleStep
			ifTrue: [self recordLastInstruction.
					self recordRegisters.
					processor
						singleStepIn: coInterpreter memory
						minimumAddress: guardPageSize
						readOnlyBelow: coInterpreter cogCodeSize]
			ifFalse: [processor
						runInMemory: coInterpreter memory
						minimumAddress: guardPageSize
						readOnlyBelow: coInterpreter cogCodeSize]]]
		on: ProcessorSimulationTrap
		do: [:ex| | retpc |
			"If the ip is out of bounds the return has already occurred."
			((processor pc between: 0 and: coInterpreter cogCodeSize)
			 and: [processor sp <= spOnEntry]) ifTrue:
				[retpc := processor leafRetpcIn: coInterpreter memory.
				 self assert: retpc = 16rBADF00D5.
				 self recordInstruction: {'(simulated return to '. retpc. ')'.
				 processor simulateLeafReturnIn: coInterpreter memory}.
				 self recordRegisters]].
	^processor cResultRegister