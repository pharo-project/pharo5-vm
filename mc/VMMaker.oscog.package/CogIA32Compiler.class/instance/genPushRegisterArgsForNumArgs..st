smalltalk calling convention
genPushRegisterArgsForNumArgs: numArgs
	"Ensure that the register args are pushed before the retpc for arity <= self numRegArgs."
	"This won't be as clumsy on a RISC.  But putting the receiver and
	 args above the return address means the CoInterpreter has a
	 single machine-code frame format which saves us a lot of work."
	numArgs <= cogit numRegArgs ifTrue:
		[self assert: cogit numRegArgs <= 2.
		 "N.B. Take great care to /not/ smash TempReg, which is used in directed send marshalling."
		 "Swap the return address with ReceiverResultReg"
		 cogit gen: XCHGMwrR operand: 0 operand: SPReg operand: ReceiverResultReg. "Save return address; replace with receiver"
		 numArgs > 0 ifTrue:
			[cogit PushR: Arg0Reg.
			 numArgs > 1 ifTrue:
				[cogit PushR: Arg1Reg]].
		cogit PushR: ReceiverResultReg.
		"Reload ReceiverResultReg"
		cogit MoveMw: numArgs + 1 * objectMemory wordSize r: SPReg R: ReceiverResultReg]