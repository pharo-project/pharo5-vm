initialization
genMustBeBooleanTrampolineFor: boolean called: trampolineName
	"This can be entered in one of two states, depending on SendNumArgsReg. See
	 e.g. genJumpIf:to:.  If SendNumArgsReg is non-zero then this has been entered via
	 the initial test of the counter in the jump executed count (i.e. the counter has
	 tripped).  In this case TempReg contains the boolean to be tested and should not
	 be offset, and ceCounterTripped should be invoked with the unoffset TempReg.
	 If SendNumArgsReg is zero then this has been entered for must-be-boolean
	 processing. TempReg has been offset by boolean and must be corrected and
	 ceSendMustBeBoolean: invoked with the corrected value."
	<var: #trampolineName type: #'char *'>
	| jumpMBB |
	<var: #jumpMBB type: #'AbstractInstruction *'>
	<inline: false>
	self zeroOpcodeIndex.
	self CmpCq: 0 R: SendNumArgsReg.
	jumpMBB := self JumpZero: 0.
	"Open-code self compileTrampolineFor: #ceCounterTripped: numArgs: 1 arg: TempReg ...
	 so we can restore ResultReceiverReg."
	self genSmalltalkToCStackSwitch: true.
	self
		compileCallFor: #ceCounterTripped:
		numArgs: 1
		arg: TempReg
		arg: nil
		arg: nil
		arg: nil
		resultReg: TempReg "(*)"
		regsToSave: self emptyRegisterMask.
	"(*) For the case where the ceCounterTripped: call returns (e.g. because there's no callback selector
	 installed), the call to the ceSendMustBeBooleanAddTrue/FalseTrampoline is followed by a jump
	 back to the start of the counter/condition test sequence.  For this case copy the C result to
	 TempReg (the register that is tested), to reload it with the boolean to be tested."
	backEnd genLoadStackPointers.
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	"To keep ResultReceiverReg live if optStatus thought it was, simply reload it
	 from the frame pointer.  This avoids having to reload it in the common case
	 (counter does not trip) if it was live.  Note we can't use putSelfInReceiverResultReg
	 when generating trampolines because simSelf has not yet been initialized."
	self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg.
	self RetN: 0.
	"If the objectRepresentation does want true & false to be mobile then we need to record these addresses."
	self assert: (objectRepresentation shouldAnnotateObjectReference: boolean) not.
	jumpMBB jmpTarget: (self AddCq: boolean R: TempReg).
	^self genTrampolineFor: #ceSendMustBeBoolean:
		called: trampolineName
		numArgs: 1
		arg: TempReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: true