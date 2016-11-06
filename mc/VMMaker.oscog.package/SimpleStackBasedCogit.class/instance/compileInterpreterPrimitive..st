primitive generators
compileInterpreterPrimitive: primitiveRoutine
	"Compile a call to an interpreter primitive.  Call the C routine with the
	 usual stack-switching dance, test the primFailCode and then either
	 return on success or continue to the method body."
	<var: #primitiveRoutine declareC: 'void (*primitiveRoutine)(void)'>
	| flags jmp jmpSamplePrim continuePostSamplePrim jmpSampleNonPrim continuePostSampleNonPrim |
	<var: #jmp type: #'AbstractInstruction *'>
	<var: #jmpSamplePrim type: #'AbstractInstruction *'>
	<var: #jmpSampleNonPrim type: #'AbstractInstruction *'>
	<var: #continuePostSamplePrim type: #'AbstractInstruction *'>
	<var: #continuePostSampleNonPrim type: #'AbstractInstruction *'>

	"Save processor fp, sp and return pc in the interpreter's frame stack and instruction pointers"
	self genExternalizePointersForPrimitiveCall.
	"Switch to the C stack."
	self genLoadCStackPointersForPrimCall.

	flags := coInterpreter primitivePropertyFlags: primitiveIndex.
	(flags anyMask: PrimCallDoNotJIT) ifTrue:
		[^ShouldNotJIT].

	(flags anyMask: PrimCallCollectsProfileSamples) ifTrue:
		["Test nextProfileTick for being non-zero and call checkProfileTick if so"
		objectMemory wordSize = 4
			ifTrue:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self MoveAw: coInterpreter nextProfileTickAddress + objectMemory wordSize R: ClassReg.
				 self OrR: TempReg R: ClassReg]
			ifFalse:
				[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
				 self CmpCq: 0 R: TempReg].
		"If set, jump to record sample call."
		jmpSampleNonPrim := self JumpNonZero: 0.
		continuePostSampleNonPrim := self Label].

	"Old full prim trace is in VMMaker-eem.550 and prior"
	self recordPrimTrace ifTrue:
		[self genFastPrimTraceUsing: ClassReg and: SendNumArgsReg].

	"Clear the primFailCode and set argumentCount"
	self MoveCq: 0 R: TempReg.
	self MoveR: TempReg Aw: coInterpreter primFailCodeAddress.
	methodOrBlockNumArgs ~= 0 ifTrue:
		[self MoveCq: methodOrBlockNumArgs R: TempReg].
	self MoveR: TempReg Aw: coInterpreter argumentCountAddress.

	"If required, set primitiveFunctionPointer and newMethod"
	(flags anyMask: PrimCallNeedsPrimitiveFunction) ifTrue:
		[self MoveCw: primitiveRoutine asInteger R: TempReg.
		 primSetFunctionLabel :=
		 self MoveR: TempReg Aw: coInterpreter primitiveFunctionPointerAddress].
	(flags anyMask: PrimCallNeedsNewMethod+PrimCallMayCallBack) ifTrue:
		["The ceActivateFailingPrimitiveMethod: machinery can't handle framelessness."
		 (flags anyMask: PrimCallMayCallBack) ifTrue:
			[needsFrame := true].
		 methodLabel addDependent:
			(self annotateAbsolutePCRef:
				(self MoveCw: methodLabel asInteger R: ClassReg)).
		 self MoveMw: (self offset: CogMethod of: #methodObject) r: ClassReg R: TempReg.
		 self MoveR: TempReg Aw: coInterpreter newMethodAddress].

	"Invoke the primitive"
	self PrefetchAw: coInterpreter primFailCodeAddress.
	(flags anyMask: PrimCallMayCallBack)
		ifTrue: "Sideways call the C primitive routine so that we return through cePrimReturnEnterCogCode."
			["On Spur ceActivateFailingPrimitiveMethod: would like to retry if forwarders
			  are found. So insist on PrimCallNeedsPrimitiveFunction being set too."
			 self assert: (flags anyMask: PrimCallNeedsPrimitiveFunction).
			 backEnd genSubstituteReturnAddress:
				((flags anyMask: PrimCallCollectsProfileSamples)
					ifTrue: [cePrimReturnEnterCogCodeProfiling]
					ifFalse: [cePrimReturnEnterCogCode]).
			 primInvokeInstruction := self JumpFullRT: primitiveRoutine asInteger.
			 jmp := jmpSamplePrim := continuePostSamplePrim := nil]
		ifFalse:
			["Call the C primitive routine."
			primInvokeInstruction := self CallFullRT: primitiveRoutine asInteger.
			(flags anyMask: PrimCallCollectsProfileSamples) ifTrue:
				[self assert: (flags anyMask: PrimCallNeedsNewMethod).
				"Test nextProfileTick for being non-zero and call checkProfileTick if so"
				objectMemory wordSize = 4
					ifTrue:
						[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
						 self MoveAw: coInterpreter nextProfileTickAddress + objectMemory wordSize R: ClassReg.
						 self OrR: TempReg R: ClassReg]
					ifFalse:
						[self MoveAw: coInterpreter nextProfileTickAddress R: TempReg.
						 self CmpCq: 0 R: TempReg].
				"If set, jump to record sample call."
				jmpSamplePrim := self JumpNonZero: 0.
				continuePostSamplePrim := self Label].
			objectRepresentation maybeCompileRetryOnPrimitiveFail: primitiveIndex.
			self maybeCompileAllocFillerCheck.
			"Switch back to the Smalltalk stack.  Stack better be in either of these two states:
				success:	stackPointer ->	result (was receiver)
											arg1
											...
											argN
											return pc
				failure:						receiver
											arg1
											...
							stackPointer ->	argN
											return pc
			In either case we can push the instructionPointer or load it into the LinkRegister to reestablish the return pc"
			self MoveAw: coInterpreter instructionPointerAddress
				R: (backEnd hasLinkRegister ifTrue: [LinkReg] ifFalse: [ClassReg]).
			backEnd genLoadStackPointers.
			"Test primitive failure"
			self MoveAw: coInterpreter primFailCodeAddress R: TempReg.
			backEnd hasLinkRegister ifFalse: [self PushR: ClassReg]. "Restore return pc on CISCs"
			self flag: 'ask concrete code gen if move sets condition codes?'.
			self CmpCq: 0 R: TempReg.
			jmp := self JumpNonZero: 0.
			"Fetch result from stack"
			self MoveMw: (backEnd hasLinkRegister ifTrue: [0] ifFalse: [objectMemory wordSize])
				r: SPReg
				R: ReceiverResultReg.
			self RetN: objectMemory wordSize].	"return to caller, popping receiver"

	(flags anyMask: PrimCallCollectsProfileSamples) ifTrue:
		["The sample is collected by cePrimReturnEnterCogCode for external calls"
		jmpSamplePrim ifNotNil:
			["Call ceCheckProfileTick: to record sample and then continue."
			jmpSamplePrim jmpTarget: self Label.
			self assert: (flags anyMask: PrimCallNeedsNewMethod).
			self CallFullRT: (self cCode: [#ceCheckProfileTick asUnsignedIntegerPtr]
							   inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
			"reenter the post-primitive call flow"
			self Jump: continuePostSamplePrim].
		"Null newMethod and call ceCheckProfileTick: to record sample and then continue.
		 ceCheckProfileTick will map null/0 to coInterpreter nilObject"
		jmpSampleNonPrim jmpTarget: self Label.
		self MoveCq: 0 R: TempReg.
		self MoveR: TempReg Aw: coInterpreter newMethodAddress.
		self CallFullRT: (self cCode: [#ceCheckProfileTick asUnsignedIntegerPtr]
						   inSmalltalk: [self simulatedTrampolineFor: #ceCheckProfileTick]).
		"reenter the post-primitive call flow"
		self Jump: continuePostSampleNonPrim].

	jmp ifNotNil:
		["Jump to restore of receiver reg and proceed to frame build for failure."
		 jmp jmpTarget: self Label.
		 "Restore receiver reg from stack.  If on RISCs ret pc is in LinkReg, if on CISCs ret pc is on stack."
		 self MoveMw: objectMemory wordSize * (methodOrBlockNumArgs + (backEnd hasLinkRegister ifTrue: [0] ifFalse: [1]))
			r: SPReg
			R: ReceiverResultReg].
	^0