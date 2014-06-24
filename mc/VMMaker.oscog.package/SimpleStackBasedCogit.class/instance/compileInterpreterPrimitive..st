primitive generators
compileInterpreterPrimitive: primitiveRoutine
	"Compile a call to an interpreter primitive.  Call the C routine with the
	 usual stack-switching dance, test the primFailCode and then either
	 return on success or continue to the method body."
	<var: #primitiveRoutine declareC: 'void (*primitiveRoutine)(void)'>
	| flags jmp jmpSamplePrim continuePostSamplePrim jmpSampleNonPrim continuePostSampleNonPrim |
	<var: #jmp type: #'AbstractInstruction *'>
	<var: #jmpSamplePrim type: #'AbstractInstruction *'>
	<var: #continuePostSamplePrim type: #'AbstractInstruction *'>
	<var: #jmpSampleNonPrim type: #'AbstractInstruction *'>
	<var: #continuePostSampleNonPrim type: #'AbstractInstruction *'>

	"Save processor fp, sp and return pc in the interpreter's frame stack and instruction pointers"
	self genExternalizePointersForPrimitiveCall.
	"Switch to the C stack."
	self genLoadCStackPointersForPrimCall.

	flags := coInterpreter primitivePropertyFlags: primitiveIndex.
	(flags bitAnd: PrimCallCollectsProfileSamples) ~= 0 ifTrue:
		["Test nextProfileTick for being non-zero and call checkProfileTick if so"
		BytesPerWord = 4
			ifTrue:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self MoveAw: coInterpreter nextProfileTickAddress + BytesPerWord R: ClassReg.
				 self OrR: TempReg R: ClassReg]
			ifFalse:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self CmpCq: 0 R: TempReg].
		"If set, jump to record sample call."
		jmpSampleNonPrim := self JumpNonZero: 0.
		continuePostSampleNonPrim := self Label].

	"Clear the primFailCode and set argumentCount"
	self MoveCq: 0 R: TempReg.
	self MoveR: TempReg Aw: coInterpreter primFailCodeAddress.
	methodOrBlockNumArgs ~= 0 ifTrue:
		[self MoveCq: methodOrBlockNumArgs R: TempReg].
	self MoveR: TempReg Aw: coInterpreter argumentCountAddress.
	(flags bitAnd: PrimCallNeedsPrimitiveFunction) ~= 0 ifTrue:
		[self MoveCw: primitiveRoutine asInteger R: TempReg.
		 self MoveR: TempReg Aw: coInterpreter primitiveFunctionPointerAddress].
	"Old full prim trace is in VMMaker-eem.550 and prior"
	self recordPrimTrace ifTrue:
		[self genFastPrimTraceUsing: ClassReg and: SendNumArgsReg].
	((flags bitAnd: PrimCallNeedsNewMethod+PrimCallMayCallBack) ~= 0) ifTrue:
		["The ceActivateFailingPrimitiveMethod: machinery can't handle framelessness."
		 (flags bitAnd: PrimCallMayCallBack) ~= 0 ifTrue:
			[needsFrame := true].
		 methodLabel addDependent:
			(self annotateAbsolutePCRef:
				(self MoveCw: methodLabel asInteger R: ClassReg)).
		 self MoveMw: (self offset: CogMethod of: #methodObject) r: ClassReg R: TempReg.
		 self MoveR: TempReg Aw: coInterpreter newMethodAddress].
	self PrefetchAw: coInterpreter primFailCodeAddress.
	(flags bitAnd: PrimCallMayCallBack) ~= 0
		ifTrue: "Sideways call the C primitive routine so that we return through cePrimReturnEnterCogCode."
			[backEnd genSubstituteReturnAddress:
				((flags bitAnd: PrimCallCollectsProfileSamples) ~= 0
					ifTrue: [cePrimReturnEnterCogCodeProfiling]
					ifFalse: [cePrimReturnEnterCogCode]).
			 self JumpRT: primitiveRoutine asInteger.
			 primInvokeLabel := self Label.
			 jmp := jmpSamplePrim := continuePostSamplePrim := nil]
		ifFalse:
			["Call the C primitive routine."
			self CallRT: primitiveRoutine asInteger.
			primInvokeLabel := self Label.
			(flags bitAnd: PrimCallCollectsProfileSamples) ~= 0 ifTrue:
				[self assert: (flags bitAnd: PrimCallNeedsNewMethod) ~= 0.
				"Test nextProfileTick for being non-zero and call checkProfileTick if so"
				BytesPerWord = 4
					ifTrue:
						[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
						 self MoveAw: coInterpreter nextProfileTickAddress + BytesPerWord R: ClassReg.
						 self OrR: TempReg R: ClassReg]
					ifFalse:
						[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
						 self CmpCq: 0 R: TempReg].
				"If set, jump to record sample call."
				jmpSamplePrim := self JumpNonZero: 0.
				continuePostSamplePrim := self Label].
			self maybeCompileAllocFillerCheck.
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
			In either case we can push the instructionPointer to reestablish the return pc"
			self MoveAw: coInterpreter instructionPointerAddress R: ClassReg.
			backEnd genLoadStackPointers.
			"Test primitive failure"
			self MoveAw: coInterpreter primFailCodeAddress R: TempReg.
			self PushR: ClassReg. "Restore return pc"
			self flag: 'ask concrete code gen if move sets condition codes?'.
			self CmpCq: 0 R: TempReg.
			jmp := self JumpNonZero: 0.
			"Fetch result from stack"
			self MoveMw: BytesPerWord r: SPReg R: ReceiverResultReg.
			self flag: 'currently caller pushes result'.
			self RetN: BytesPerWord].

	(flags bitAnd: PrimCallCollectsProfileSamples) ~= 0 ifTrue:
		["The sample is collected by cePrimReturnEnterCogCode for external calls"
		jmpSamplePrim notNil ifTrue:
			["Call ceCheckProfileTick: to record sample and then continue."
			jmpSamplePrim jmpTarget: self Label.
			self assert: (flags bitAnd: PrimCallNeedsNewMethod) ~= 0.
			self CallRT: (self cCode: '(unsigned long)ceCheckProfileTick'
							   inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
			"reenter the post-primitive call flow"
			self Jump: continuePostSamplePrim].
		"Null newMethod and call ceCheckProfileTick: to record sample and then continue.
		 ceCheckProfileTick will map null/0 to coInterpreter nilObject"
		jmpSampleNonPrim jmpTarget: self Label.
		self MoveCq: 0 R: TempReg.
		self MoveR: TempReg Aw: coInterpreter newMethodAddress.
		self CallRT: (self cCode: '(unsigned long)ceCheckProfileTick'
						   inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
		"reenter the post-primitive call flow"
		self Jump: continuePostSampleNonPrim].

	jmp notNil ifTrue:
		["Jump to restore of receiver reg and proceed to frame build for failure."
		 jmp jmpTarget: self Label.
		 "Restore receiver reg from stack."
		 self MoveMw: BytesPerWord * (methodOrBlockNumArgs + 1) r: SPReg R: ReceiverResultReg].
	^0