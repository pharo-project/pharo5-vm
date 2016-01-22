simulation stack
marshallAbsentReceiverSendArguments: numArgs
	self assert: needsFrame.
	self ssAllocateCallReg: ReceiverResultReg.
	self putSelfInReceiverResultReg.

	"Spill everything on the simulated stack that needs spilling (that below arguments).
	 Marshall arguments to stack and/or registers depending on arg count.
	 If the args don't fit in registers push receiver and args (spill everything).  Assume
	 receiver already in ResultReceiverReg so shuffle args and push it if necessary."
	self ssFlushTo: simStackPtr - numArgs.
	numArgs > self numRegArgs
		ifTrue:
			["The arguments must be pushed to the stack, and hence the receiver
			   must be inserted beneath the args.  Reduce or eliminate the argument
			   shuffle by only moving already spilled items."
			| numSpilled |
			numSpilled := self numberOfSpillsInTopNItems: numArgs.
			numSpilled > 0
				ifTrue:
					[self MoveMw: 0 r: SPReg R: TempReg.
					 self PushR: TempReg.
					 2 to: numSpilled do:
						[:index|
						self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
						self MoveR: TempReg Mw: index - 1 * objectMemory wordSize r: SPReg].
					 self MoveR: ReceiverResultReg Mw: numSpilled * objectMemory wordSize r: SPReg]
				ifFalse:
					[self PushR: ReceiverResultReg].
			self ssFlushTo: simStackPtr]
		"Move the args to the register arguments, being careful to do
		 so last to first so e.g. previous contents don't get overwritten.
		 Also check for any arg registers in use by other args."
		ifFalse:
			[numArgs > 0 ifTrue:
				[(self numRegArgs > 1 and: [numArgs > 1])
					ifTrue:
						[self ssAllocateRequiredReg: Arg0Reg upThrough: simStackPtr - 2.
						 self ssAllocateRequiredReg: Arg1Reg upThrough: simStackPtr - 1]
					ifFalse:
						[self ssAllocateRequiredReg: Arg0Reg upThrough: simStackPtr - 1]].
			 (self numRegArgs > 1 and: [numArgs > 1]) ifTrue:
				[(self simStackAt: simStackPtr) popToReg: Arg1Reg].
			 numArgs > 0 ifTrue:
				[(self simStackAt: simStackPtr - numArgs + 1)
					popToReg: Arg0Reg]].
	self ssPop: numArgs