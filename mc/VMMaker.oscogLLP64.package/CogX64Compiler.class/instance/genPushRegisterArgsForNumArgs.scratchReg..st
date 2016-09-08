smalltalk calling convention
genPushRegisterArgsForNumArgs: numArgs scratchReg: scratchReg
	"Ensure that the register args are pushed before the retpc for arity <= self numRegArgs.  This
	 isn't as clumsy on a RISC.  But putting the receiver and args above the return address
	 means the CoInterpreter has a single machine-code frame format which saves us a lot of work.
	 N.B. Take great care to /not/ smash TempReg, which is used in directed send marshalling.
	 We could use XCHG to swap the ReceiverResultReg and top-of-stack return address, pushing the
	 the ret pc (now in ReceiverResultReg) later, but XCHG is very slow.  We can use SendNumArgsReg
	 because it is only live in sends of arity >= (NumSendTrampolines - 1)."
	self assert: cogit numRegArgs < (NumSendTrampolines - 1).
	numArgs <= cogit numRegArgs ifTrue:
		[self assert: cogit numRegArgs <= 2.
		 false "these two variants show the same performance on Intel Core i7, but the second one may be shorter."
			ifTrue:
				[cogit MoveMw: 0 r: SPReg R: scratchReg. "Save return pc"
				 numArgs > 0 ifTrue:
					[cogit PushR: Arg0Reg.
					 numArgs > 1 ifTrue:
						[cogit PushR: Arg1Reg]].
				 cogit PushR: scratchReg.
				 cogit MoveR: ReceiverResultReg Mw: objectMemory wordSize * (1 + numArgs) r: SPReg]
			ifFalse:
				["a.k.a.
					cogit gen: XCHGMwrR operand: 0 operand: SPReg operand: ReceiverResultReg.
				  but XCHG is slow."
				 cogit MoveMw: 0 r: SPReg R: scratchReg. "Save return pc"
				 cogit MoveR: ReceiverResultReg Mw: 0 r: SPReg.
				 numArgs > 0 ifTrue:
					[cogit PushR: Arg0Reg.
					 numArgs > 1 ifTrue:
						[cogit PushR: Arg1Reg]].
				 cogit PushR: scratchReg]] "Restore return address"