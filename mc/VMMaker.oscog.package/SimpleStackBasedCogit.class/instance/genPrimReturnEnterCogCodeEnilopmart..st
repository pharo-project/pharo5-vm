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

	self maybeCompileAllocFillerCheck.

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
		failure:							receiver
										arg1
										...
					stackPointer	->	argN
										return pc
	We push the instructionPointer to reestablish the return pc in the success case,
	but leave it to ceActivateFailingPrimitiveMethod: to do so in the failure case."

	backEnd hasLinkRegister
		ifTrue:
			[backEnd genLoadStackPointers.									"Switch back to Smalltalk stack."
			 self MoveMw: 0 r: SPReg R: ReceiverResultReg.						"Fetch result from stack"
			 self MoveAw: coInterpreter instructionPointerAddress R: LinkReg.	"Get and restore ret pc"
			 self RetN: BytesPerWord]											"Return, popping result from stack"
		ifFalse:
			[self MoveAw: coInterpreter instructionPointerAddress R: ClassReg.	"Get return pc"
			 backEnd genLoadStackPointers.									"Switch back to Smalltalk stack."
			 self MoveMw: 0 r: SPReg R: ReceiverResultReg.						"Fetch result from stack"
			 self MoveR: ClassReg Mw: 0 r: SPReg.								"Restore return pc"
			 self RetN: 0].														"Return, popping result from stack"

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
		["Call ceCheckProfileTick: to record sample and then continue.  newMethod
		 should be up-to-date.  Need to save and restore the link reg around this call."
		 jmpSample jmpTarget: self Label.
		 backEnd hasLinkRegister ifTrue: [self PushR: LinkReg].
		 self CallRT: (self cCode: '(unsigned long)ceCheckProfileTick'
						inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
		 backEnd hasLinkRegister ifTrue: [self PopR: LinkReg].
		 self Jump: continuePostSample]