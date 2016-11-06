initialization
genPrimReturnEnterCogCodeEnilopmart: profiling
	"Generate the substitute return code for an external or FFI primitive call.
	 On success simply return, extracting numArgs from newMethod.
	 On primitive failure call ceActivateFailingPrimitiveMethod: newMethod."
	| jmpSample continuePostSample jmpFail |
	<var: #jmpSample type: #'AbstractInstruction *'>
	<var: #continuePostSample type: #'AbstractInstruction *'>
	<var: #jmpFail type: #'AbstractInstruction *'>
	self zeroOpcodeIndex.
	backEnd hasVarBaseRegister ifTrue:
		[self MoveCq: self varBaseAddress R: VarBaseReg]. "Must happen sometime"

	profiling ifTrue:
		["Test nextProfileTick for being non-zero and call checkProfileTick: if so.
		  N.B. nextProfileTick is 64-bits so 32-bit systems need to test both halves."
		objectMemory wordSize = 4
			ifTrue:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self MoveAw: coInterpreter nextProfileTickAddress + objectMemory wordSize R: ClassReg.
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
			[backEnd genLoadStackPointers.											"Switch back to Smalltalk stack."
			 backEnd hasPCRegister
				ifTrue:
					[self PopR: ReceiverResultReg.										"Pop result from stack"
					 self MoveAw: coInterpreter instructionPointerAddress R: PCReg]	"Return"
				ifFalse:
					[self MoveMw: 0 r: SPReg R: ReceiverResultReg.						"Fetch result from stack"
					 self MoveAw: coInterpreter instructionPointerAddress R: LinkReg.	"Get ret pc"
					 self RetN: objectMemory wordSize]]								"Return, popping result from stack"
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
	self 
		compileCallFor: #ceActivateFailingPrimitiveMethod:
		numArgs: 1
		arg: SendNumArgsReg
		arg: nil
		arg: nil
		arg: nil
		resultReg: NoReg
		regsToSave: self emptyRegisterMask.

	"On Spur ceActivateFailingPrimitiveMethod: may retry the primitive and return if successful.
	 So continue by returning to the caller.
	 Switch back to the Smalltalk stack.  Stack should be in this state:
				success:	stackPointer ->	result (was receiver)
											arg1
											...
											argN
											return pc
	 We can push the instructionPointer or load it into the LinkRegister to reestablish the return pc"
	self MoveAw: coInterpreter instructionPointerAddress
		R: (backEnd hasLinkRegister ifTrue: [LinkReg] ifFalse: [ClassReg]).
	backEnd genLoadStackPointers.
	backEnd hasLinkRegister
		ifTrue:
			[self MoveMw: 0 r: SPReg R: ReceiverResultReg]	"Fetch result from stack"
		ifFalse:
			[self MoveMw: objectMemory wordSize r: SPReg R: ReceiverResultReg.	"Fetch result from stack"
			 self PushR: ClassReg].											"Restore return pc on CISCs"
	self RetN: objectMemory wordSize.	"return to caller, popping receiver"

	profiling ifTrue:
		["Call ceCheckProfileTick: to record sample and then continue.  newMethod
		 should be up-to-date.  Need to save and restore the link reg around this call."
		 jmpSample jmpTarget: self Label.
		 backEnd saveAndRestoreLinkRegAround:
			[self CallFullRT: (self cCode: '(usqIntptr_t)ceCheckProfileTick'
						inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick])].
		 self Jump: continuePostSample]