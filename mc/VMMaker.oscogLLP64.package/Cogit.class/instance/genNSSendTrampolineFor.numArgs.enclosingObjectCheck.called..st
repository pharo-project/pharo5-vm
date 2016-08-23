initialization
genNSSendTrampolineFor: aRoutine numArgs: numArgs enclosingObjectCheck: eoCheckFlag called: aString
	"ReceiverResultReg: method receiver
	SendNumArgsReg: the NSSendCache cache"
	<option: #NewspeakVM>
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	| jumpMiss jumpItsTheReceiverStupid |
	<var: #jumpMiss type: #'AbstractInstruction *'>
	<var: #jumpItsTheReceiverStupid type: #'AbstractInstruction *'>
	self zeroOpcodeIndex.
	objectRepresentation
		genGetInlineCacheClassTagFrom: ReceiverResultReg
		into: ClassReg
		forEntry: false.
	self MoveMw: NSCClassTagIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
	self CmpR: ClassReg R: TempReg.
	jumpMiss := self JumpNonZero: 0.

	eoCheckFlag ifTrue:
		[self MoveMw: NSCEnclosingObjectIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
		self CmpCq: 0 R: TempReg.
		jumpItsTheReceiverStupid := self JumpZero: 0.
		self MoveR: TempReg R: ReceiverResultReg.
		"Now set the stacked receiver, if needed.  If there are reg args this is
		 not required; see genPushRegisterArgsForNumArgs:numArgs: below."
		(self numRegArgs = 0 or: [numArgs > self numRegArgs]) ifTrue:
			[numArgs >= (NumSendTrampolines - 1)
				ifTrue: "arbitrary argument count"
					[self MoveMw: NSCNumArgsIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
					 backEnd hasLinkRegister ifFalse:
						[self AddCq: 1 R: TempReg]..
					 self MoveR: ReceiverResultReg Xwr: TempReg R: SPReg]
				ifFalse: "Known argument count"
					[self MoveR: TempReg Mw: (backEnd hasLinkRegister ifTrue: [0] ifFalse: [1]) + numArgs * objectMemory wordSize r: SPReg]].
		jumpItsTheReceiverStupid jmpTarget: self Label].

	self MoveMw: NSCTargetIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
	self JumpR: TempReg.

	jumpMiss jmpTarget: self Label.
	objectRepresentation
		genEnsureOopInRegNotForwarded: ReceiverResultReg
		scratchReg: TempReg
		updatingMw: FoxMFReceiver
		r: FPReg.
	self numRegArgs > 0 ifTrue:
		[backEnd genPushRegisterArgsForNumArgs: numArgs scratchReg: TempReg].
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 2
		arg: SendNumArgsReg "The NSSendCache"
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		regsToSave: self emptyRegisterMask
		pushLinkReg: true
		resultReg: NoReg
		appendOpcodes: true