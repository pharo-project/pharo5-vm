simulation only
simulateCogCodeAt: address "<Integer>"
	<doNotGenerate>
	| stackZoneBase |
	stackZoneBase := coInterpreter stackZoneBase.
	processor pc: address.
	[[[singleStep
		ifTrue:
			[[processor sp < stackZoneBase ifTrue: [self halt].
			  self recordProcessing.
			  self maybeBreakAt: processor pc] value. "So that the Debugger's Over steps over all this"
			  processor
					singleStepIn: coInterpreter memory
					minimumAddress: guardPageSize
					readOnlyBelow: methodZone zoneEnd]
		ifFalse:
			[processor
					runInMemory: coInterpreter memory
					minimumAddress: guardPageSize
					readOnlyBelow: methodZone zoneEnd].
	   "((printRegisters or: [printInstructions]) and: [clickConfirm]) ifTrue:
	 	[(self confirm: 'continue?') ifFalse:
			[clickConfirm := false. self halt]]."
	   true] whileTrue]
		on: ProcessorSimulationTrap
		do: [:ex| self handleSimulationTrap: ex].
	 true] whileTrue