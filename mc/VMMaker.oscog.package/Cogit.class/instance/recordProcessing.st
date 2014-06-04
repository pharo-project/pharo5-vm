simulation only
recordProcessing
	| inst |
	self recordRegisters.
	inst := self recordLastInstruction.
	printRegisters ifTrue:
		[processor printRegistersOn: coInterpreter transcript].
	printInstructions ifTrue:
		[printRegisters ifTrue:
			[coInterpreter transcript cr].
		 coInterpreter transcript nextPutAll: inst; cr; flush]