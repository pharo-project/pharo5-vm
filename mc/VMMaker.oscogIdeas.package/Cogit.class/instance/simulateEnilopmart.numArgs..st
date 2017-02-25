simulation only
simulateEnilopmart: enilopmartAddress numArgs: n
	<doNotGenerate>
	"Enter Cog code, popping the class reg and receiver from the stack
	 and then returning to the address beneath them.
	 In the actual VM the enilopmart is a function pointer and so senders
	 of this method end up calling the enilopmart to enter machine code.
	 In simulation we either need to start simulating execution (if we're in
	 the interpreter) or return to the simulation (if we're in the run-time
	 called from machine code. We should also smash the register state
	 since, being an abnormal entry, no saved registers will be restored."
	self assert: (coInterpreter isOnRumpCStack: processor sp).
	self assert: ((coInterpreter stackValue: n) between: guardPageSize and: methodZone freeStart - 1).
	"As a convenience for stack printing, nil localFP so we know we're in machine code."
	coInterpreter nilLocalFP.
	(printInstructions or: [printRegisters]) ifTrue:
		[coInterpreter printExternalHeadFrame].
	processor
		smashRegistersWithValuesFrom: 16r80000000 by: objectMemory wordSize;
		simulateLeafCallOf: enilopmartAddress
		nextpc: 16rBADF00D
		memory: coInterpreter memory.
	"If we're already simulating in the context of machine code then
	 this will take us back to handleCallSimulationTrap:.  Otherwise
	 start executing machine code in the simulator."
	(ReenterMachineCode new returnValue: #continueNoReturn) signal.
	self simulateCogCodeAt: enilopmartAddress.
	"We should either longjmp back to the interpreter or
	 stay in machine code so control should not reach here."
	self assert: false