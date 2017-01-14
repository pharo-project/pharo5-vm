simulation only
handleCallOrJumpSimulationTrap: aProcessorSimulationTrap
	<doNotGenerate>
	| evaluable function result savedFramePointer savedStackPointer savedArgumentCount rpc |
	evaluable := simulatedTrampolines at: aProcessorSimulationTrap address.
	function := evaluable isBlock
					ifTrue: ['aBlock; probably some plugin primitive']
					ifFalse:
						[evaluable receiver == backEnd ifTrue:
							[^self handleABICallOrJumpSimulationTrap: aProcessorSimulationTrap evaluable: evaluable].
						 evaluable selector].
	function ~~ #ceBaseFrameReturn: ifTrue:
		[coInterpreter assertValidExternalStackPointers].
	(function beginsWith: 'ceShort') ifTrue:
		[^self perform: function with: aProcessorSimulationTrap].
	aProcessorSimulationTrap type = #call
		ifTrue:
			[processor
				simulateCallOf: aProcessorSimulationTrap address
				nextpc: aProcessorSimulationTrap nextpc
				memory: coInterpreter memory.
			self recordInstruction: {'(simulated call of '. aProcessorSimulationTrap address. '/'. function. ')'}]
		ifFalse:
			[processor
				simulateJumpCallOf: aProcessorSimulationTrap address
				memory: coInterpreter memory.
			 self recordInstruction: {'(simulated jump to '. aProcessorSimulationTrap address. '/'. function. ')'}].
	savedFramePointer := coInterpreter framePointer.
	savedStackPointer := coInterpreter stackPointer.
	savedArgumentCount := coInterpreter argumentCount.
	result := ["self halt: evaluable selector."
		   	   ((printRegisters or: [printInstructions]) and: [clickConfirm]) ifTrue:
			 	[(self confirm: 'skip run-time call?') ifFalse:
					[clickConfirm := false. self halt]].
			   evaluable valueWithArguments: (processor
												postCallArgumentsNumArgs: evaluable numArgs
												in: coInterpreter memory)]
				on: ReenterMachineCode
				do: [:ex| ex return: ex returnValue].
			
	coInterpreter assertValidExternalStackPointers.
	"Verify the stack layout assumption compileInterpreterPrimitive: makes, provided we've
	 not called something that has built a frame, such as closure value or evaluate method, or
	 switched frames, such as primitiveSignal, primitiveWait, primitiveResume, primitiveSuspend et al."
	(function beginsWith: 'primitive') ifTrue:
		[coInterpreter checkForLastObjectOverwrite.
		 coInterpreter primFailCode = 0
			ifTrue: [(#(	primitiveClosureValue primitiveClosureValueWithArgs primitiveClosureValueNoContextSwitch
						primitiveFullClosureValue primitiveFullClosureValueWithArgs primitiveFullClosureValueNoContextSwitch
						primitiveSignal primitiveWait primitiveResume primitiveSuspend primitiveYield
						primitiveExecuteMethodArgsArray primitiveExecuteMethod
						primitivePerform primitivePerformWithArgs primitivePerformInSuperclass
						primitiveTerminateTo primitiveStoreStackp primitiveDoPrimitiveWithArgs)
							includes: function) ifFalse:
						[self assert: savedFramePointer = coInterpreter framePointer.
						 self assert: savedStackPointer + (savedArgumentCount * objectMemory wordSize)
								= coInterpreter stackPointer]]
			ifFalse:
				[self assert: savedFramePointer = coInterpreter framePointer.
				 self assert: savedStackPointer = coInterpreter stackPointer]].
	result ~~ #continueNoReturn ifTrue:
		[self recordInstruction: {'(simulated return to '. processor retpcIn: coInterpreter memory. ')'}.
		 rpc := processor retpcIn: coInterpreter memory.
		 self assert: (rpc >= codeBase and: [rpc < methodZone freeStart]).
		 processor
			smashCallerSavedRegistersWithValuesFrom: 16r80000000 by: objectMemory wordSize;
			simulateReturnIn: coInterpreter memory].
	self assert: (result isInteger "an oop result"
			or: [result == coInterpreter
			or: [result == objectMemory
			or: [#(nil continue continueNoReturn) includes: result]]]).
	processor cResultRegister: (result
							ifNil: [0]
							ifNotNil: [result isInteger
										ifTrue: [result]
										ifFalse: [16rF00BA222]])

	"coInterpreter cr.
	 processor sp + 32 to: processor sp - 32 by: -4 do:
		[:sp|
		 sp = processor sp
			ifTrue: [coInterpreter print: 'sp->'; tab]
			ifFalse: [coInterpreter printHex: sp].
		 coInterpreter tab; printHex: (coInterpreter longAt: sp); cr]"