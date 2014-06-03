smalltalk calling convention
genPushRegisterArgsForNumArgs: numArgs
	"Ensure that the register args are pushed before the retpc for arity <= self numRegArgs."
	"This is easy on a RISC like ARM because the return address is in the link register.  Putting
	 the receiver and args above the return address means the CoInterpreter has a single
	 machine-code frame format which saves us a lot of work."
	numArgs <= cogit numRegArgs ifTrue:
		[self assert: cogit numRegArgs <= 2.
		 numArgs > 0 ifTrue:
			[cogit PushR: ReceiverResultReg.
			 cogit PushR: Arg0Reg.
			 numArgs > 1 ifTrue:
				[cogit PushR: Arg1Reg]]]