initialization
genPrimReturnEnterCogCodeEnilopmart: profiling
	"Generate the substitute return code for an external or FFI primitive call.
	 On success simply return, extracting numArgs from newMethod.
	 On primitive failure call ceActivateFailingPrimitiveMethod: newMethod."
	| jmpSample continuePostSample jmpFail |
	<var: #jmpSample type: #'AbstractInstruction *'>
	<var: #continuePostSample type: #'AbstractInstruction *'>
	<var: #jmpFail type: #'AbstractInstruction *'>
	opcodeIndex := 0.

	profiling ifTrue:
		["Test nextProfileTick for being non-zero and call checkProfileTick: if so.
		  N.B. nextProfileTick is 64-bits so 32-bit systems need to test both halves."
		BytesPerWord = 4
			ifTrue:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self MoveAw: coInterpreter nextProfileTickAddress + BytesPerWord R: ClassReg.
				 self OrR: TempReg R: ClassReg]
			ifFalse:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self CmpCq: 0 R: TempReg].
		"If set, jump to record sample call."
		jmpSample := self JumpNonZero: 0.
		continuePostSample := self Label].

	"Test primitive failure"
	self MoveAw: coInterpreter primFailCodeAddress R: TempReg.
	self flag: 'ask concrete code gen if move sets condition codes?'.
	self CmpCq: 0 R: TempReg.
	jmpFail := self JumpNonZero: 0.

	"Switch back to the Smalltalk stack.  Stack better be in either of these two states:
		success:	stackPointer	->	result (was receiver)
									arg1
									...
									argN
									return pc
		failure:						receiver
									arg1
									...
					stackPointer	->	argN
									return pc
	We push the instructionPointer to reestablish the return pc in the success case,
	but leave it to ceActivateFailingPrimitiveMethod: to do so in the failure case."

	self MoveAw: coInterpreter instructionPointerAddress R: ClassReg.
	self genLoadStackPointers.
	self PushR: ClassReg. "Restore return pc"
	"Fetch result from stack"
	self MoveMw: BytesPerWord r: SPReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord.

	"Primitive failed.  Invoke C code to build the frame and continue."
	jmpFail jmpTarget: (self MoveAw: coInterpreter newMethodAddress R: SendNumArgsReg).
	"Reload sp with CStackPointer; easier than popping args of checkProfileTick."
	self MoveAw: self cStackPointerAddress R: SPReg.
	cStackAlignment > BytesPerWord ifTrue:
		[backEnd
			genAlignCStackSavingRegisters: false
			numArgs: 1
			wordAlignment: cStackAlignment / BytesPerWord].
	backEnd genPassReg: SendNumArgsReg asArgument: 0.
	self CallRT: (self cCode: '(unsigned long)ceActivateFailingPrimitiveMethod'
					inSmalltalk: [self simulatedTrampolineFor: #ceActivateFailingPrimitiveMethod:]).

	profiling ifTrue:
		["Call ceCheckProfileTick: to record sample and then continue.
		  newMethod should be up-to-date."
		 jmpSample jmpTarget: self Label.
		 self CallRT: (self cCode: '(unsigned long)ceCheckProfileTick'
						inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
		 self Jump: continuePostSample]