compile abstract instructions
genPushRegisterArgsForNumArgs: numArgs
	"Ensure that the register args are pushed before the retpc for arity <= self numRegArgs."
	"This won't be as clumsy on a RISC.  But putting the receiver and
	 args above the return address means the CoInterpreter has a
	 single machine-code frame format which saves us a lot of work."
	numArgs <= self numRegArgs ifTrue:
		[self MoveMw: 0 r: SPReg R: TempReg. "Save return address"
		 self MoveR: ReceiverResultReg Mw: 0 r: SPReg.
		 self assert: self numRegArgs <= 2.
		 numArgs > 0 ifTrue:
			[self PushR: Arg0Reg.
			 numArgs > 1 ifTrue:
				[self PushR: Arg1Reg]].
		self PushR: TempReg] "Restore return address"