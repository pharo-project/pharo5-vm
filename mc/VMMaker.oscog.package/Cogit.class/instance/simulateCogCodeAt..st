simulation only
simulateCogCodeAt: address "<Integer>"
	<doNotGenerate>
	| stackZoneBase |
	stackZoneBase := coInterpreter stackZoneBase.
	processor pc: address.
	[[[singleStep ifTrue:
		[[processor sp < stackZoneBase ifTrue: [self halt].
		  self recordProcessing.
		  (breakPC isInteger
			ifTrue:
				[processor pc = breakPC
				 and: [breakBlock value: self]]
			ifFalse:
				[breakBlock value: self]) ifTrue:
			["printRegisters := printInstructions := true"
			 "self reportLastNInstructions"
			 "coInterpreter printExternalHeadFrame"
			 "coInterpreter printFrameAndCallers: coInterpreter framePointer SP: coInterpreter stackPointer"
			 "coInterpreter shortPrintFrameAndCallers: coInterpreter framePointer"
			 "coInterpreter printFrame: processor fp WithSP: processor sp"
			 "coInterpreter printFrameAndCallers: processor fp SP: processor sp"
			 "coInterpreter shortPrintFrameAndCallers: processor fp"
			"self disassembleMethodFor: processor pc"
			 coInterpreter changed: #byteCountText.
			 self halt: 'machine code breakpoint at ', processor pc hex]] value]. "So that the Debugger's Over steps over all this"
	   singleStep
		ifTrue: [processor
					singleStepIn: coInterpreter memory
					minimumAddress: guardPageSize
					readOnlyBelow: methodZone zoneEnd]
		ifFalse: [processor
					runInMemory: coInterpreter memory
					minimumAddress: guardPageSize
					readOnlyBelow: methodZone zoneEnd].
	   ((printRegisters or: [printInstructions]) and: [clickConfirm]) ifTrue:
	 	[(self confirm: 'continue?') ifFalse:
			[self halt]].
	   true] whileTrue]
		on: ProcessorSimulationTrap
		do: [:ex| self handleSimulationTrap: ex].
	 true] whileTrue