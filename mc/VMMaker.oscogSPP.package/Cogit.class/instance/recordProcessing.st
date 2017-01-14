simulation only
recordProcessing
	| inst |
	self recordRegisters.
	inst := self recordLastInstruction.
	"Set RRRName ito the selector that accesses ReceiverResultReg (RRR) to alter instruction printing to add the value of RRR as a suffix
		(RRRName := #rdx)
		(RRRName := #edx)
		(RRRName := nil)"
	printRegisters ifTrue:
		[RRRName ifNil: [processor printRegistersOn: coInterpreter transcript].
		 printInstructions ifFalse:
			[coInterpreter transcript cr]].
	printInstructions ifTrue:
		[printRegisters ifTrue:
			[coInterpreter transcript cr].
		 coInterpreter transcript nextPutAll: inst.
		 RRRName ifNotNil:
			[coInterpreter transcript space; nextPutAll: RRRName; space.
			 (processor perform: RRRName) printOn: coInterpreter transcript base: 16 length: 8 padded: false].
		 coInterpreter transcript cr; flush]