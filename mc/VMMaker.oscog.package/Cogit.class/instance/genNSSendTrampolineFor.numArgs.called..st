initialization
genNSSendTrampolineFor: aRoutine numArgs: numArgs called: aString
	"ReceiverResultReg: method receiver
	SendNumArgsReg: the NSSendCache cache"
	<option: #NewspeakVM>
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	| jumpMiss jumpItsTheReceiverStupid |
	<var: #jumpMiss type: #'AbstractInstruction *'>
	<var: #jumpItsTheReceiverStupid type: #'AbstractInstruction *'>
	opcodeIndex := 0.
	objectRepresentation
		genGetInlineCacheClassTagFrom: ReceiverResultReg
		into: ClassReg
		forEntry: false.
	self MoveMw: NSCClassTagIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
	self CmpR: ClassReg R: TempReg.
	jumpMiss := self JumpNonZero: 0.
	self MoveMw: NSCEnclosingObjectIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
	self CmpCq: 0 R: TempReg.
	jumpItsTheReceiverStupid := self JumpZero: 0.
	self MoveR: TempReg R: ReceiverResultReg.
	"We don't patch stack(-numArgs). See comment in ceImplicitReceiverSend:receiver:"
	jumpItsTheReceiverStupid jmpTarget: self Label.
	self MoveMw: NSCTargetIndex * objectMemory wordSize r: SendNumArgsReg R: TempReg.
	self JumpR: TempReg.

	jumpMiss jmpTarget: self Label.
	objectRepresentation
		genEnsureObjInRegNotForwarded: ReceiverResultReg
		scratchReg: TempReg
		updatingMw: FoxMFReceiver
		r: FPReg.
	backEnd genPushRegisterArgsForNumArgs: numArgs.
	^self
		genTrampolineFor: aRoutine
		called: aString
		numArgs: 2
		arg: SendNumArgsReg "The NSSendCache"
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		saveRegs: false
		pushLinkReg: true
		resultReg: ReceiverResultReg  "Never happens?"
		appendOpcodes: true