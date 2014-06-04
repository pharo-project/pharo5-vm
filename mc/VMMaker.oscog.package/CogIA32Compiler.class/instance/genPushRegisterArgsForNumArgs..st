smalltalk calling convention
genPushRegisterArgsForNumArgs: numArgs
	"Ensure that the register args are pushed before the retpc for arity <= self numRegArgs."
	"This won't be as clumsy on a RISC.  But putting the receiver and
	 args above the return address means the CoInterpreter has a
	 single machine-code frame format which saves us a lot of work."
	numArgs <= cogit numRegArgs ifTrue:
		[self assert: cogit numRegArgs <= 2.
		 false "these two variants show the same performance on Intel Core i7, but the second one may be shorter."
			ifTrue:
				[cogit MoveMw: 0 r: SPReg R: TempReg. "Save return address"
				 numArgs > 0 ifTrue:
					[cogit PushR: Arg0Reg.
					 numArgs > 1 ifTrue:
						[cogit PushR: Arg1Reg]].
				 cogit PushR: TempReg.
				 cogit MoveR: ReceiverResultReg Mw: BytesPerWord * (1 + numArgs) r: SPReg]
			ifFalse:
				[cogit MoveMw: 0 r: SPReg R: TempReg. "Save return address"
				 cogit MoveR: ReceiverResultReg Mw: 0 r: SPReg.
				 numArgs > 0 ifTrue:
					[cogit PushR: Arg0Reg.
					 numArgs > 1 ifTrue:
						[cogit PushR: Arg1Reg]].
				cogit PushR: TempReg]] "Restore return address"